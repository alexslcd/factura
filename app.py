from flask import Flask, redirect, url_for
from blueprints import register_blueprints


app = Flask(__name__)
app.secret_key = 'alexito'

register_blueprints(app)

@app.route('/')
def index():
    return redirect(url_for('login.login'))

if __name__ == '__main__':
    app.run(debug=True)
