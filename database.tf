resource "aws_db_instance" "postgres"{
  allocated_storage    = 10
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "password"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.postgres.name
}

resource "aws_db_subnet_group" "postgres" {
  name       = "postgres-subnet-group"
  subnet_ids = [aws_subnet.private.id]
}

