# hash_password.py
from werkzeug.security import generate_password_hash

# Ingresar la contraseña que deseas almacenar
password = input("Introduce la contraseña: ")

# Generar el hash de la contraseña
hashed_password = generate_password_hash(password)

print(f"El hash de la contraseña es: {hashed_password}")
