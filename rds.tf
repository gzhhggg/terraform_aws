# resource "aws_db_subnet_group" "default" {
#   name = "rds-subnet-group"
#   description = "rds-subnet-group"
#   subnet_ids = [for subnet in aws_subnet.private :subnet.id]
# }

# resource "aws_rds_cluster_parameter_group" "default" {
#   name = "parameter-group-mysql8"
#   family = "mysql8.0"
# }

# resource "aws_db_option_group" "default" {
#   name = "rds-parameter-group-mysql80"
#   engine_name = "mysql"
#   major_engine_version = "8.0"
# }

# # お金がかかるのでこっちにする
# resource "aws_db_instance" "default" {
#   identifier           = "test-db"
#   allocated_storage    = 20
#   storage_type         = "gp2"
#   engine               = "mysql"
#   engine_version       = "8.0.32"
#   instance_class       = "db.t2.micro"
#   db_name                 = "testdb"
#   username             = var.username
#   password             = var.password
#   multi_az = false
#   vpc_security_group_ids  = [aws_security_group.private.id]
#   db_subnet_group_name = aws_db_subnet_group.default.name
#   skip_final_snapshot = true
# }