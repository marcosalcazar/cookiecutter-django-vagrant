#!/usr/bin/env bash

sudo su - postgres -c 'dropdb {{cookiecutter.repo_name}}'
sudo su - postgres -c 'createdb {{cookiecutter.repo_name}}'
sudo su - postgres -c 'createuser {{cookiecutter.repo_name}}'
sudo -u postgres psql -c "alter user {{cookiecutter.repo_name}} with password '{{cookiecutter.repo_name}}';"
sudo -u postgres psql -c "grant all privileges on database {{cookiecutter.repo_name}} to {{cookiecutter.repo_name}};"
