import pymysql.cursors

# Configuración de la conexión a la base de datos
def get_db_connection():
    return pymysql.connect(
        host='127.0.0.1',  # Cambia por tu host si es necesario
        user='alexito',       # Cambia por tu usuario
        password='salcedo1A',       # Cambia por tu contraseña
        database='facturacion_db',  # Asegúrate de tener la base de datos creada
        cursorclass=pymysql.cursors.DictCursor
    )
