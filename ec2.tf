data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/20.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

resource "aws_launch_template" "lt" {
  name_prefix   = "stream-server"
  image_id      = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type = "t2.micro"
  key_name      = "my-key"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.sg.id]
    subnet_id                   = aws_subnet.public.id
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo apt update && sudo apt upgrade -y

    # Instalar dependencias
    sudo apt install -y build-essential libpcre3 libpcre3-dev libssl-dev zlib1g zlib1g-dev unzip wget

    # Descargar Nginx y módulo RTMP
    wget http://nginx.org/download/nginx-1.21.6.tar.gz
    wget https://github.com/arut/nginx-rtmp-module/archive/refs/heads/master.zip

    # Extraer
    tar -zxvf nginx-1.21.6.tar.gz
    unzip master.zip

    # Compilar con RTMP
    cd nginx-1.21.6
    ./configure --add-module=../nginx-rtmp-module-master --with-http_ssl_module
    make
    sudo make install

    # Configurar Nginx para RTMP
    sudo bash -c 'cat > /usr/local/nginx/conf/nginx.conf' <<EOL
    worker_processes  1;
    events {
        worker_connections  1024;
    }
    http {
        include       mime.types;
        default_type  application/octet-stream;
        sendfile        on;
        keepalive_timeout  65;
        server {
            listen       80;
            location / {
                root   html;
                index  index.html index.htm;
            }
        }
    }
    rtmp {
        server {
            listen 1935;
            chunk_size 4096;
            application live {
                live on;
                record off;
            }
        }
    }
    EOL

    # Crear index
    echo "<h1>Servidor de Streaming con NGINX-RTMP</h1>" | sudo tee /usr/local/nginx/html/index.html

    # Iniciar Nginx
    sudo /usr/local/nginx/sbin/nginx
  EOF
  )
}
