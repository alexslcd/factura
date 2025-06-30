from flask import Blueprint, render_template, request, redirect, url_for, flash
from data import get_db_connection
from datetime import datetime
import traceback

proveedores_bp = Blueprint('proveedores', __name__, url_prefix='/proveedores')

@proveedores_bp.route('/')
def listar_proveedores():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM proveedores ORDER BY fecha_registro DESC")
    proveedores = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('proveedor/proveedores.html', proveedores=proveedores)

@proveedores_bp.route('/proveedores/crear', methods=['GET', 'POST'])
def crear_proveedor():
    if request.method == 'POST':
        try:
            documento_numero = request.form['documento_numero'].strip()
            documento_tipo = request.form['documento_tipo']
            nombre = request.form['nombre'].strip()
            direccion = request.form['direccion'].strip()
            telefono = request.form['telefono'].strip()
            correo = request.form['correo'].strip()
            estado = request.form['estado']

            # Validaciones
            if not documento_numero:
                flash('El RUC no puede estar vacío.', 'warning')
                return render_template('proveedor/crear_proveedor.html', form=request.form)

            if documento_tipo == 'RUC':
                if not documento_numero.isdigit() or len(documento_numero) != 11:
                    flash('El RUC debe tener 11 dígitos numéricos.', 'warning')
                    return render_template('proveedor/crear_proveedor.html', form=request.form)
                if not (documento_numero.startswith('10') or documento_numero.startswith('20')):
                    flash('El RUC debe comenzar con "10" o "20".', 'warning')
                    return render_template('proveedor/crear_proveedor.html', form=request.form)

            conn = get_db_connection()
            with conn.cursor() as cursor:
                cursor.execute("""
                    SELECT * FROM proveedores 
                    WHERE documento_numero = %s OR nombre = %s
                """, (documento_numero, nombre))
                proveedor_existente = cursor.fetchone()

                if proveedor_existente:
                    flash('Ya existe un proveedor con el mismo nombre o número de documento.', 'warning')
                    conn.close()
                    return render_template('proveedor/crear_proveedor.html', form=request.form)

                fecha_registro = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                cursor.execute("""
                    INSERT INTO proveedores (
                        documento_numero, documento_tipo, nombre, direccion,
                        telefono, correo, estado, fecha_registro
                    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """, (
                    documento_numero, documento_tipo, nombre, direccion,
                    telefono, correo, estado, fecha_registro
                ))
                conn.commit()

            flash('Proveedor registrado correctamente.', 'success')
            conn.close()
            return render_template('proveedor/crear_proveedor.html')  # se queda en la misma página

        except Exception as e:
            print("Error al registrar proveedor:", e)
            flash(f'Ocurrió un error inesperado: {e}', 'danger')
            return render_template('proveedor/crear_proveedor.html', form=request.form)

    return render_template('proveedor/crear_proveedor.html')
