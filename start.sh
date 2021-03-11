#!/usr/bin/env bash

download_react_app() {
  if ! command node --version &> /dev/null
  then
    echo "nodejs could not be found"
    command curl "https://nodejs.org/dist/latest/node-${VERSION:-$(wget -qO- https://nodejs.org/dist/latest/ | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')}.pkg" > "$HOME/Downloads/node-latest.pkg" && sudo installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"
    echo "please execute ./start.sh again"
    exit
  else
    command npx create-react-app web
  fi
}

exec_docker() {
  if ! command docker-compose &> /dev/null
  then
    echo "Please install docker https://docs.docker.com/get-docker/"
  else
    command docker-compose up -d
  fi
}

init() {
  if [[ ! -n "./web" ]]; then
    download_react_app
  fi
  
  exec_docker
}

init

cat <<EOF
  🚀 Yey, success to install create-react-app

  * please check with the process with docker ps
  * if you want to remove just type docker-compose down -v --rmi all --remove-orphans
EOF
