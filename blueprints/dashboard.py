from flask import Blueprint, render_template, session, redirect, url_for, request
from data import get_db_connection
import pymysql

dashboard_bp = Blueprint('dashboard', __name__)

@dashboard_bp.route('/dashboard')
def dashboard():
    nombre_usuario = session.get('nombre_usuario')
    if not nombre_usuario:
        return redirect(url_for('login.login'))

    # Filtros desde la URL
    fecha_inicio = request.args.get('fecha_inicio')
    fecha_fin = request.args.get('fecha_fin')
    cliente_id = request.args.get('cliente')

    # Construcción dinámica de condiciones
    condiciones = []
    params = []

    if fecha_inicio:
        condiciones.append("f.fecha_emision >= %s")
        params.append(fecha_inicio)

    if fecha_fin:
        condiciones.append("f.fecha_emision <= %s")
        params.append(fecha_fin)

    if cliente_id:
        condiciones.append("f.cliente_documento_numero = %s")
        params.append(cliente_id)

    where_clause = " AND ".join(condiciones)
    if where_clause:
        where_clause = "WHERE " + where_clause

    conn = get_db_connection()
    cursor = conn.cursor(pymysql.cursors.DictCursor)

    # Total clientes
    cursor.execute("SELECT COUNT(*) AS total_clientes FROM clientes;")
    total_clientes = cursor.fetchone()['total_clientes']

    # Total ventas
    cursor.execute(f"""
        SELECT SUM(f.total) AS total_ventas 
        FROM facturas f
        JOIN detalle_factura df ON f.id = df.factura_id
        JOIN productos p ON df.producto_id = p.id
        {where_clause}
    """, params)
    total_ventas = cursor.fetchone()['total_ventas'] or 0.0

    # Total productos vendidos
    cursor.execute(f"""
        SELECT SUM(df.cantidad) AS productos_vendidos 
        FROM facturas f
        JOIN detalle_factura df ON f.id = df.factura_id
        JOIN productos p ON df.producto_id = p.id
        {where_clause}
    """, params)
    productos_vendidos = cursor.fetchone()['productos_vendidos'] or 0

    # Producto más vendido
    cursor.execute(f"""
        SELECT p.nombre, SUM(df.cantidad) AS total_vendidos
        FROM detalle_factura df
        JOIN productos p ON df.producto_id = p.id
        JOIN facturas f ON df.factura_id = f.id
        {where_clause}
        GROUP BY p.id
        ORDER BY total_vendidos DESC
        LIMIT 1
    """, params)
    mas_vendido = cursor.fetchone()

    # Producto menos vendido
    cursor.execute(f"""
        SELECT p.nombre, SUM(df.cantidad) AS total_vendidos
        FROM detalle_factura df
        JOIN productos p ON df.producto_id = p.id
        JOIN facturas f ON df.factura_id = f.id
        {where_clause}
        GROUP BY p.id
        ORDER BY total_vendidos ASC
        LIMIT 1
    """, params)
    menos_vendido = cursor.fetchone()

    # Mejor cliente
    cursor.execute(f"""
        SELECT c.documento_numero, c.nombre, SUM(f.total) AS total_compras
        FROM clientes c
        JOIN facturas f ON c.documento_numero = f.cliente_documento_numero
        JOIN detalle_factura df ON f.id = df.factura_id
        JOIN productos p ON df.producto_id = p.id
        {where_clause}
        GROUP BY c.documento_numero
        ORDER BY total_compras DESC
        LIMIT 1
    """, params)
    mejor_cliente = cursor.fetchone()

    # Ventas por día
    cursor.execute(f"""
        SELECT DATE(f.fecha_emision) AS fecha_emision, SUM(f.total) AS total_dia
        FROM facturas f
        JOIN detalle_factura df ON f.id = df.factura_id
        JOIN productos p ON df.producto_id = p.id
        {where_clause}
        GROUP BY DATE(f.fecha_emision)
        ORDER BY f.fecha_emision ASC
    """, params)
    ventas_por_dia = cursor.fetchall()

    # Productos más vendidos por día
    cursor.execute(f"""
        SELECT DATE(f.fecha_emision) AS fecha_emision, p.nombre, SUM(df.cantidad) AS cantidad
        FROM detalle_factura df
        JOIN productos p ON df.producto_id = p.id
        JOIN facturas f ON df.factura_id = f.id
        {where_clause}
        GROUP BY DATE(f.fecha_emision), p.nombre
        ORDER BY fecha_emision ASC, cantidad DESC
    """, params)
    productos_por_dia = cursor.fetchall()

    # Ventas por mes
    cursor.execute(f"""
        SELECT DATE_FORMAT(f.fecha_emision, '%%Y-%%m') AS mes, SUM(f.total) AS total_mes
        FROM facturas f
        JOIN detalle_factura df ON f.id = df.factura_id
        JOIN productos p ON df.producto_id = p.id
        {where_clause}
        GROUP BY mes
        ORDER BY mes ASC
    """, params)
    ventas_por_mes = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template(
        'dashboard.html',
        nombre_usuario=nombre_usuario,
        total_clientes=total_clientes,
        total_ventas=total_ventas,
        productos_vendidos=productos_vendidos,
        mas_vendido=mas_vendido,
        menos_vendido=menos_vendido,
        mejor_cliente=mejor_cliente,
        ventas_por_dia=ventas_por_dia,
        productos_por_dia=productos_por_dia,
        ventas_por_mes=ventas_por_mes,
        request=request
    )
