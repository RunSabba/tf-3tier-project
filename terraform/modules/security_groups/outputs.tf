output "ec2_security_group_id" {
  value = aws_security_group.runsabba_ec2_sg.id
}

output "lb_security_group_id" {
  value = aws_security_group.lb_security_group.id
}

output "db_security_group_id" {
  value = aws_security_group.db_security_group.id
}
