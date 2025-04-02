resource "random_pet" "bucket_suffix" {
  length = 2
}

resource "aws_s3_bucket" "videos" {
  bucket = "video-storage-${random_pet.bucket_suffix.id}"
}

resource "aws_elasticache_parameter_group" "redis7" {
  name   = "custom-redis7"
  family = "redis7"
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "stream-cache"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.redis7.name 
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
}


resource "aws_elasticache_subnet_group" "redis" {
  name       = "redis-subnet-group"
  subnet_ids = [aws_subnet.private.id]
}

