from flask import Blueprint, render_template, request, redirect, url_for, flash
from data import get_db_connection
from datetime import datetime

clientes_bp = Blueprint('clientes', __name__, url_prefix='/clientes')

@clientes_bp.route('/')
def listar_clientes():
    registrado = request.args.get('registrado')
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM clientes')
    clientes = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('clientes/listar_clientes.html', clientes=clientes, registrado=registrado)

@clientes_bp.route('/crear', methods=['GET', 'POST'])
def crear_cliente():
    if request.method == 'POST':
        documento_numero = request.form['documento_numero'].strip()
        documento_tipo = request.form['documento_tipo']
        nombre = request.form['nombre'].strip()
        direccion = request.form.get('direccion', '')
        telefono = request.form.get('telefono', '')
        correo = request.form.get('correo', '')
        estado = 1
        fecha_registro = datetime.now()

        # Validaciones
        if documento_tipo == 'DNI':
            if not (documento_numero.isdigit() and len(documento_numero) == 8):
                flash('El número de DNI debe contener exactamente 8 dígitos numéricos.', 'warning')
                return render_template('clientes/clientes.html', **request.form)

        elif documento_tipo == 'RUC':
            if not (documento_numero.isdigit() and len(documento_numero) == 11):
                flash('El número de RUC debe contener exactamente 11 dígitos numéricos.', 'warning')
                return render_template('clientes/clientes.html', **request.form)
            if not (documento_numero.startswith('10') or documento_numero.startswith('20')):
                flash('El RUC debe comenzar con "10" o "20".', 'warning')
                return render_template('clientes/clientes.html', **request.form)

        # Verificar duplicado
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute(
            'SELECT COUNT(*) AS cantidad FROM clientes WHERE nombre = %s AND documento_numero = %s',
            (nombre, documento_numero)
        )
        resultado = cursor.fetchone()
        duplicado = resultado['cantidad'] if resultado else 0

        if duplicado > 0:
            flash('⚠️ Ya existe un cliente con ese nombre y número de documento.', 'warning')
            cursor.close()
            conn.close()
            return render_template('clientes/clientes.html', **request.form)

        # Insertar nuevo cliente
        try:
            cursor.execute(
                '''
                INSERT INTO clientes 
                (documento_numero, documento_tipo, nombre, direccion, telefono, correo, estado, fecha_registro)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                ''',
                (documento_numero, documento_tipo, nombre, direccion, telefono, correo, estado, fecha_registro)
            )
            conn.commit()

            # ✅ Mostrar mensaje de éxito en modal y resetear formulario
            flash('✅ Cliente registrado correctamente.', 'success')
            return render_template('clientes/clientes.html')  # No reenviar datos previos

        except Exception as e:
            flash(f'❌ Error al registrar cliente: {e}', 'danger')
            return render_template('clientes/clientes.html', **request.form)

        finally:
            cursor.close()
            conn.close()

    # GET
    return render_template('clientes/clientes.html')
