Docker.options = {
  client_cert: File.join(ENV['CERT_PATH'], 'cert.pem'),
  client_key: File.join(ENV['CERT_PATH'], 'key.pem'),
  ssl_ca_file: File.join(ENV['CERT_PATH'], 'ca.pem'),
  scheme: 'https'
}

Docker.url='tcp://192.168.99.100:2376'


