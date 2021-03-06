#!/usr/bin/env bash
RED='\033[0;31m'

printf "${RED}## Atualizando ##"
apt-get update -y

printf "${RED}## Instalando Dependências e Bibliotecas ##"
apt-get install git -y
apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev libstdc++6:i386 g++ -y

printf "${RED}## Instalando NodeJs 6.x ##"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install nodejs -y

printf "${RED}## Instalando Yarn ##"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt-get update -y
apt-get install yarn

printf "${RED}## Corrigindo Permissões ##"
mkdir /.npm-global
chown vagrant:vagrant /.npm-global
chmod 777 -R /.npm-global
npm config set prefix '/.npm-global'
echo "export PATH=/.npm-global/bin:/vagrant/app/node_modules/.bin/:/home/vagrant/.yarn/bin/:\$PATH" >> /home/vagrant/.profile
echo "cd /vagrant/app" >> /home/vagrant/app/.profile
cd /vagrant

printf "${RED}## Instalando Dependências Front-End ##"
yarn global add create-react-app
yarn install
# 