resource "aws_db_instance" "runsabba_db_1" {
    allocated_storage = 20
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.7.44"
    instance_class = var.instance_class #errors running t2.micro on mysql 5.7 version. t3.micro resolved errors.
    db_subnet_group_name = "database-subnet-group"
    vpc_security_group_ids = [var.db_security_group_id]
    parameter_group_name = "default.mysql5.7"
    db_name = "runsabba_db_1"
    username = var.db_username
    password = var.db_password
    allow_major_version_upgrade = true
    auto_minor_version_upgrade = true
    backup_retention_period = 35
    backup_window = "22:00-23:00"
    maintenance_window = "Sat:00:00-Sat:06:00"
    multi_az = false
    skip_final_snapshot = true
}

resource "aws_db_instance" "runsabba_db_2" {
    allocated_storage = 20
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.7.44" #if version error: aws rds describe-db-engine-versions --engine mysql --query  --output text
    instance_class = var.instance_class
    db_subnet_group_name = "database-subnet-group"
    vpc_security_group_ids = [var.db_security_group_id]
    parameter_group_name = "default.mysql5.7"
    db_name = "runsabba_db_2"
    username = var.db_username
    password = var.db_password
    allow_major_version_upgrade = true
    auto_minor_version_upgrade = true
    backup_retention_period = 35
    backup_window = "22:00-23:00"
    maintenance_window = "Sat:00:00-Sat:06:00"
    multi_az = false
    skip_final_snapshot = true
}