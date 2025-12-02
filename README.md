<h1 align="center">
    <br>
    <a href="https://alextselegidis.com/get/plainpad">
        <img src="https://raw.githubusercontent.com/alextselegidis/plainpad/master/logo.png" alt="Plainpad" width="200">
    </a>
    <br>
    Plainpad Docker
    <br>
</h1>

<br>

<h4 align="center">
    A self-hosted, open source note taking application that can be installed on your server. 
</h4>

<p align="center">
  <img alt="GitHub" src="https://img.shields.io/github/license/alextselegidis/plainpad?style=for-the-badge">
  <img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/alextselegidis/plainpad?style=for-the-badge">
  <img alt="GitHub All Releases" src="https://img.shields.io/github/downloads/alextselegidis/plainpad/total?style=for-the-badge">
  <a href="https://discord.com/invite/UeeSkaw">
    <img alt="Chat On Discord" src="https://img.shields.io/badge/chat-on%20discord-7289da?style=for-the-badge&logo=discord&logoColor=white">
  </a>
</p>

<p align="center">
  <a href="#about">About</a> •
  <a href="#features">Features</a> •
  <a href="#setup">Setup</a> •
  <a href="#installation">Installation</a> •
  <a href="#license">License</a>
</p>

## About

**Plainpad** is a self-hosted, open source note taking application that prioritizes simplicity and privacy. 
It allows you to create, organize, and manage your notes through a clean and intuitive web interface. 
As an open source project, you can download and install it **even for commercial use**. 
Plainpad gives you complete control over your data, running entirely on your own server without any third-party dependencies.

## Features

The application is designed to provide a distraction-free note-taking experience with essential features:

* Clean and intuitive user interface.
* Markdown support for formatting.
* Note organization and search.
* Self-hosted installation.
* Complete data ownership and privacy.
* Multi-user support.
* Responsive design for mobile and desktop.
* Open source and customizable.

## Setup

To clone and run this application, you'll need [Git](https://git-scm.com), [Node.js](https://nodejs.org/en/download/) (which comes with [npm](http://npmjs.com)) and [Composer](https://getcomposer.org) installed on your computer. From your command line:

```bash
# Start a MySQL instance
$ docker run -d --name test-db -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=plainpad mysql:latest

# Pull and run the app
$ docker run --name test-app -d --link test-db:db -p 80:80 -e DB_HOST=db -e DB_NAME=plainpad -e DB_USERNAME=root -e DB_PASSWORD=secret alextselegidis/plainpad:latest
```

Note: If you're using Linux Bash for Windows, [see this guide](https://www.howtogeek.com/261575/how-to-run-graphical-linux-desktop-applications-from-windows-10s-bash-shell/) or use `node` from the command prompt.

## Docker Compose

You can use the following docker-compose.yml file to locally set up Plainpad with a MySQL database: 

```
services:

  plainpad:
    image: alextselegidis/plainpad:latest
    ports:
      - '80:80'
    environment:
      - BASE_URL=http://localhost
      - DEBUG_MODE=TRUE
      - DB_HOST=mysql
      - DB_NAME=plainpad
      - DB_USERNAME=root
      - DB_PASSWORD=secret
    
  mysql:
    image: mysql:8.0
    environment:
      - MYSQL_ROOT_PASSWORD=secret
      - MYSQL_DATABASE=plainpad
      
```

## License 

Code Licensed Under [GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) | Content Under [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/)

---

Website [alextselegidis.com](https://alextselegidis.com) &nbsp;&middot;&nbsp;
GitHub [alextselegidis](https://github.com/alextselegidis) &nbsp;&middot;&nbsp;
Twitter [@alextselegidis](https://twitter.com/AlexTselegidis)

