

resource "aws_db_subnet_group" "rds_subnet_grp" {
  name = "rds_subnet_group"
  subnet_ids = var.rds_subnet_ids

  tags = {
    Name = "RDS Subnet Group"
  }
}


resource "aws_db_instance" "rds" {
    allocated_storage    = 20
    db_name              = "appdatabase"
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    username             = "admin"
    password             = "db*pass123"
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot  = true

    vpc_security_group_ids = var.vpc_security_group_ids
    db_subnet_group_name = aws_db_subnet_group.rds_subnet_grp.name

    tags = {
      Name = "AppDatabase"
    }

  
}