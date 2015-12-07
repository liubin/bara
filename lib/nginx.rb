module Nginx

  @conf = '/etc/nginx/nginx.conf'
  @bin = '/usr/sbin/nginx'

  def conf=(c)
    @conf = c
  end

  def bin=(b)
    @bin = b
  end

  def template=(t)
    @template = t
  end

  def read
    IO.readlines(@conf).join()
  end

  def write(body)
    File.open(@conf, "w") do |f|
       f.puts body
    end
  end

  def reload
    system(@bin)
  end

  def generate_conf
    upstream = get_upstream
    s = @template.gsub("{{upstream}}", upstream)
    File.open(@conf, "w") do |f|
       f.puts s
    end
  end

  def get_upstream
    bs = get_backends
    bss = []

    bs.each do |p|
      ps = <<PS
  upstream backend_#{p}
  {
    server localhost:#{p};
  }
PS
      bss.push ps
    end

    ## map
    bss.push '  map $http_vvv, $u{'

    bs.each do |p|
      bss.push "    ~#{p} #{p};"
    end

    bss.push "    default #{bs.last};"

    bss.push '  }'
    bss.join("\n")
  end

  def get_backends
    backends = []
    Docker::Container.all.each do |container|
      # "Ports": [{"PrivatePort": 2222, "PublicPort": 3333, "Type": "tcp"}]
      if container.info['Ports'] and container.info['Ports'].size > 0
        p = container.info['Ports'][0]['PublicPort']
        backends.push p
      end
    end
    backends
  end

  module_function :conf=, :bin=, :template=, :read, :write, :reload, :generate_conf, :get_upstream, :get_backends
end
