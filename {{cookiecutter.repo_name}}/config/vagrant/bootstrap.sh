#!/usr/bin/env bash

apt-get update
apt-get -y upgrade

# Install general packages #
apt-get install -y git python-dev

# VIRTUALENV #
apt-get install -y python-virtualenv

virtualenv /vagrant/{{cookiecutter.repo_name}}_venv
source /vagrant/{{cookiecutter.repo_name}}_venv/bin/activate

# POSTGRESQL #
apt-get install -y libpq-dev postgresql postgresql-contrib
pip install psycopg2

chmod +x config/vagrant/postgresql.sh
./config/vagrant/postgresql.sh

# SUPERVISOR #
apt-get install -y supervisor

# GUNICORN #
pip install gunicorn
cp /vagrant/config/vagrant/gunicorn.conf /etc/supervisor/conf.d/gunicorn.conf
service supervisor restart

# NGINX #
apt-get install -y nginx
cp /vagrant/config/vagrant/nginx.txt /etc/nginx/sites-available/default
service nginx restart

# DJANGO PROJECT #
pip install -U -r /vagrant/requirements.txt
#cp /vagrant/config/vagrant/django_settings_dev.txt /vagrant/{{cookiecutter.repo_name}}/{{cookiecutter.repo_name}}/settings-dev.py

cd /vagrant
python manage.py migrate #--settings={{cookiecutter.repo_name}}.settings-dev
