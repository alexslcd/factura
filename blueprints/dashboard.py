from flask import Blueprint, render_template, session, redirect, url_for
from data import get_db_connection
import pymysql

dashboard_bp = Blueprint('dashboard', __name__)

@dashboard_bp.route('/dashboard')
def dashboard():
    nombre_usuario = session.get('nombre_usuario')
    if not nombre_usuario:
        return redirect(url_for('login.login'))

    conn = get_db_connection()
    cursor = conn.cursor(pymysql.cursors.DictCursor)

    # ✅ Cambiado: Total de clientes en lugar de facturas
    cursor.execute("SELECT COUNT(*) AS total_clientes FROM clientes;")
    total_clientes = cursor.fetchone()['total_clientes']

    # Total de ventas (suma de todos los totales de facturas)
    cursor.execute("SELECT SUM(total) AS total_ventas FROM facturas;")
    total_ventas = cursor.fetchone()['total_ventas'] or 0.0

    # Total de productos vendidos (suma de cantidades en detalle_factura)
    cursor.execute("SELECT SUM(cantidad) AS productos_vendidos FROM detalle_factura;")
    productos_vendidos = cursor.fetchone()['productos_vendidos'] or 0

    cursor.close()
    conn.close()

    return render_template(
        'dashboard.html',
        nombre_usuario=nombre_usuario,
        total_clientes=total_clientes,
        total_ventas=total_ventas,
        productos_vendidos=productos_vendidos
    )
