# Bara

Simply Docker base multi version app test environment.


**It's only a reference implementation, strongly embedded in our process. **

# How to run

[简体中文版使用说明](http://liubin.org/2015/12/08/bara-nginx-and-dokcer-based-test-env-poc/)

[日本語紹介](http://qiita.com/liubin/items/0090e2b16e5c3674b5b6)

## Configuration files

### Docker daemon

Edit `config/initializers/docker.rb`

### Nginx server

Edit `config/initializers/nginx.rb`

### .env file

```
cp .env.example .env

# settings for SMTP/Token
vi .env
source .env
```

## Start server


```
RAILS_ENV=production rake assets:precompile
RAILS_ENV=production rake db:migrate
RAILS_ENV=production rails s -b 0.0.0.0
```

## Create an account and login


## Create Nginx Configuration's template

Login and go to `/templates/new` to create template file. In the `nginx.conf` file, you kan use placeholder `{{upstream}}`, this will be substituted by running containers info.

For example:

```
{{upstream}}

server {

    location /{
      add_header u $u;
      proxy_pass http://backend_$u;
    } 
```

## Pull an image

In `http://localhost:3000/iamges` page, pull an image

## Deploy an container

In `http://localhost:3000/containers` page, create a new conatiner.


## Generate Nginx config files and reload

If you have to containers are running:

```
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                     NAMES
0e738babaf33        busybox             "httpd -p 8080 -f"   About an hour ago   Up About an hour    0.0.0.0:32770->8080/tcp   app-v2
4348bed6e1c9        busybox             "httpd -p 8080 -f"   About an hour ago   Up About an hour    0.0.0.0:32769->8080/tcp   app-v1
```

Click `Create Config File` button will generate somethins like this:

```
  upstream backend_app-v2
  {
    server localhost:32770;
  }

  upstream backend_app-v1
  {
    server localhost:32769;
  }

  map $http_v, $u{
    ~app-v2 app-v2;
    ~app-v1 app-v1;
    default app-v1;
  }

server {

    location /{
      add_header u $u;
      proxy_pass http://backend_$u;
    }
```

# Limitations and restrictions

- Can't mount local volumes
- Will expose all ports defined in `Dockerfile`
- You can specify only container name and `CMD` params when deploy new containers.
- Can process only one Nginx config file, normally it should be `/etc/nginx/nginx.conf`

# Issues or Questions

please create issue in GitHub.

# Author & Licensing

The MIT License (MIT), Copyright 2015 Bin Liu <liubin0329@gmail.com>
