import pymysql
import json
from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from flask_mail import Mail

# solved the issue for mysql db connection
pymysql.install_as_MySQLdb()

with open('config.json', 'r') as config:
    params = json.load(config)['params']

local_server = True
app = Flask(__name__)
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']
)
mail = Mail(app)
if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']
db = SQLAlchemy(app)


class Contacts(db.Model):
    """
    sno, name, phone_num, email, msg, date
    """
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(20), nullable=True)


@app.route("/")
def home():
    return render_template('index.html', params=params)


@app.route("/about")
def about():
    return render_template('about.html', params=params)


@app.route("/contact", methods=['GET', 'POST'])
def contact():
    if request.method == 'POST':
        """ Add entry to db"""
        name = request.form.get('name')
        phone = request.form.get('phone')
        email = request.form.get('email')
        message = request.form.get('message')
        """
        sno, name, phone_num, email, msg, date
        """
        entry = Contacts(name=name, phone_num=phone, email=email, date=datetime.now(), msg=message)
        db.session.add(entry)
        db.session.commit()
        """
        recipients – list of email addresses, 
        recipients should be passed as a list even if it has a single value.
        """
        mail.send_message('New message from ' + name,
                          sender=email,
                          recipients=[params['gmail-user']],
                          body=message + "\n" + phone
                          )
    return render_template('contact.html', params=params)


app.run(debug=True)
