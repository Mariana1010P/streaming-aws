resource "aws_launch_template" "lt" {
  name_prefix   = "stream-server"
  image_id      = "ami-0042e1b512ea1e723"
  instance_type = "t2.micro"
  key_name      = "my-key"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.sg.id]
    subnet_id = aws_subnet.public.id
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
    echo "<h1>Streaming Server Ready</h1>" | sudo tee /var/www/html/index.html
    sudo ufw allow 80
    sudo ufw enable
  EOF
  )
}
