#!/usr/bin/env bash

apt-get update
apt-get -y upgrade

# Install general packages #
apt-get install -y git python-dev

# Install other required packages
apt-get install -y python-virtualenv
apt-get install -y libpq-dev postgresql postgresql-contrib
apt-get install -y supervisor
apt-get install -y nginx

# Create virtualenv #
virtualenv /{{cookiecutter.repo_name}}_venv
source /{{cookiecutter.repo_name}}_venv/bin/activate

# INSTALL pip packages #
cd /vagrant
pip install -U -r requirements.txt

# POSTGRESQL #
chmod +x config/vagrant/postgresql.sh
./config/vagrant/postgresql.sh

# make all

# SUPERVISOR #
apt-get install -y supervisor

# GUNICORN #
cp /vagrant/config/vagrant/gunicorn.conf /etc/supervisor/conf.d/gunicorn.conf
service supervisor restart

# NGINX #
cp /vagrant/config/vagrant/nginx.txt /etc/nginx/sites-available/default
service nginx restart

