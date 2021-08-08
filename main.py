import pymysql
import json
from flask import Flask, render_template, request, session
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from flask_mail import Mail

# solved the issue for mysql db connection
pymysql.install_as_MySQLdb()

with open('config.json', 'r') as config:
    params = json.load(config)['params']

local_server = True
app = Flask(__name__)
app.secret_key = 'super-secret-key'
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
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(20), nullable=True)


class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(50), nullable=False)
    tagline = db.Column(db.String(50), nullable=False)
    slug = db.Column(db.String(25), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(20), nullable=True)
    img_file = db.Column(db.String(20), nullable=True)


@app.route("/")
def home():
    posts = Posts.query.filter_by().all()[0:params['no_of_posts']]
    return render_template('index.html', params=params, posts=posts)


@app.route("/about")
def about():
    return render_template('about.html', params=params)


@app.route("/dashboard", methods=['GET', 'POST'])
def dashboard():
    if 'user' in session and session['user'] == params['admin_user']:
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)

    if request.method == 'POST':
        username = request.form.get('uname')
        password = request.form.get('pass')
        if username == params['admin_user'] and password == params['admin_password']:
            # set the session variable
            session['user'] = username
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)

    return render_template('login.html', params=params)


@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)


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
