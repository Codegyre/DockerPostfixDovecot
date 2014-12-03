# Dovecot + Postfix email servers inside Docker

This docker container is aimed to run Postfix and Docker as email server.
Inside your application you can receive and manage emails using Dovecot server.

To create email addresses you need MySQL database with [tables](https://github.com/Codegyre/DockerPostfixDovecot/blob/master/mailschema.sql); add email domains into `mail_virtual_domains`, add email users to `mail_virtual_users`. 

## Pull From DockerHub

```
docker pull davert/mailserver
```

## Build Container

```
docker build -t mailserver .  
```

It is recommended to add environment vars (see below) into your Dockerfile to inject them on build.

## Run Container

Container requires access to mysql socket and directory to store emails. It also exposes email ports

```
docker run -i -t -e APP_HOST=example.com -e DB_NAME=dbname -p 25:25 -p 110:110 -p 143:143 -p 995:995 -p 587:587 -v /var/run/mysqld/:/var/run/mysqld -v /home/vmail:/home/vmail/ mailserver
```

### Environment Vars

* **APP_HOST** (required)- email server host
* **DB_NAME** (required) - database
* **DB_USER** (root) - user to access mysql database
* **DB_PASSWORD** - mysql user password

### Directories

* `/var/run/mysqld/:/var/run/mysqld/` - MySQL socket
* `/home/vmail/:/home/vmail/` - directory to store emails