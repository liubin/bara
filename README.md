# Bara

Simply Docker base multi version app test environment.


**It's only a reference implementation, strongly embedded in our process. **

# How to run

[简体中文版使用说明](http://liubin.org/2015/12/08/bara-nginx-and-dokcer-based-test-env-poc/)

## Configuration files

### Docker Daemon

Edit `config/initializers/docker.rb`

### Nginx Server

Edit `config/initializers/nginx.rb`


### Create Nginx Configuration's template

Login and go to `/templates/new` to create template file. In the `nginx.conf` file, you kan use placeholder `{{upstream}}`, this will be substituted by running containers info.


# Issues or Questions

please create issue in GitHub.

# Author & Licensing

The MIT License (MIT), Copyright 2015 Bin Liu <liubin0329@gmail.com>
