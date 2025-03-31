resource "aws_s3_bucket" "videos" {
  bucket = "my-unique-video-storage-<random-id>" 
}


resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "stream-cache"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"  # Cambiar a redis6.x si redis7.x no está disponible
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
}


resource "aws_elasticache_subnet_group" "redis"{
  name       = "redis-subnet-group"
  subnet_ids = [aws_subnet.private.id]
}
