from flask import Blueprint, render_template, request, redirect, url_for
usuarios_bp = Blueprint('usuarios', __name__, url_prefix='/usuarios')
from data import get_db_connection
from werkzeug.security import generate_password_hash

@usuarios_bp.route('/')
def listar_usuarios():
    conexion = get_db_connection()
    with conexion.cursor() as cursor:
        cursor.execute("SELECT id, username, correo, rol, estado, fecha_creacion FROM usuarios")
        usuarios = cursor.fetchall()
    conexion.close()
    return render_template('usuarios/usuarios.html', usuarios=usuarios)

@usuarios_bp.route('/registrar', methods=['GET', 'POST'])
def registrar_usuario():
    if request.method == 'POST':
        username = request.form['username']
        correo = request.form['correo']
        password = request.form['password']
        rol = request.form['rol']
        estado = int(request.form.get('estado', 1))  # 1 = activo por defecto
        
        password_hash = generate_password_hash(password)
        
        conexion = get_db_connection()
        with conexion.cursor() as cursor:
            cursor.execute("""
                INSERT INTO usuarios (username, correo, password, rol, estado)
                VALUES (%s, %s, %s, %s, %s)
            """, (username, correo, password_hash, rol, estado))
        conexion.commit()
        conexion.close()
        return redirect(url_for('usuarios.listar_usuarios'))
    return render_template('usuarios/registrar_usuario.html')

@usuarios_bp.route('/eliminar/<int:id>', methods=['GET'])
def eliminar_usuario(id):
    conexion = get_db_connection()
    with conexion.cursor() as cursor:
        cursor.execute("DELETE FROM usuarios WHERE id = %s", (id,))
        conexion.commit()
    conexion.close()
    return redirect(url_for('usuarios.listar_usuarios'))
