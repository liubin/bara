
# if you want to connect a Docker daemon not on loclhost
# you should do the following settings.
Docker.options = {
  client_cert: File.join(ENV['CERT_PATH'], 'cert.pem'),
  client_key: File.join(ENV['CERT_PATH'], 'key.pem'),
  ssl_ca_file: File.join(ENV['CERT_PATH'], 'ca.pem'),
  scheme: 'https'
}

Docker.url='tcp://192.168.99.100:2376'


# if you want to use an Unix socket to connect docker daemon
# you should set Docker.url to unix:///var/run/docker.sock

# Docker.url='unix:///var/run/docker.sock'