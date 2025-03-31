resource "aws_launch_template" "lt"{
  name_prefix   = "stream-server"
  image_id      = "ami-0041f866474ace6ea"
  instance_type = "t2.micro"
  key_name      = "my-key"
  network_interfaces {
    associate_public_ip_address = false 
    security_groups             = [aws_security_group.sg.id]
    subnet_id                   = aws_subnet.private.id 
  }
}
