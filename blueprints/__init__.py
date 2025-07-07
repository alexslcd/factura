from flask import Blueprint

def register_blueprints(app):
    from .clientes import clientes_bp
    from .productos import productos_bp
    from .facturas import facturas_bp
    from .proveedores import proveedores_bp
    from .registro_usuarios import usuarios_bp
    from .login import login_bp
    from .dashboard import dashboard_bp  # Asegúrate de importar el blueprint del dashboard

    app.register_blueprint(login_bp)
    app.register_blueprint(clientes_bp)
    app.register_blueprint(productos_bp)
    app.register_blueprint(facturas_bp)
    app.register_blueprint(proveedores_bp)
    app.register_blueprint(usuarios_bp)
    app.register_blueprint(dashboard_bp)  # Registra el blueprint del dashboard
