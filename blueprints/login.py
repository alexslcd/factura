from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from werkzeug.security import check_password_hash
from data import get_db_connection

login_bp = Blueprint('login', __name__)

@login_bp.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['usuario']
        password = request.form['password']

        if validar_usuario(username, password):
            session['nombre_usuario'] = username  # Guardar el nombre en sesión
            return redirect(url_for('dashboard.dashboard'))  # Redirigir al dashboard
        else:
            flash('Usuario o contraseña incorrectos', 'danger')

    return render_template('login.html')

@login_bp.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login.login'))

def validar_usuario(username, password):
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            sql = "SELECT username, password FROM usuarios WHERE username = %s"
            cursor.execute(sql, (username,))
            user = cursor.fetchone()

            if user and check_password_hash(user['password'], password):
                return True
            else:
                return False
    finally:
        connection.close()