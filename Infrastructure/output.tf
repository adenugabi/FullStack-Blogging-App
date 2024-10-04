output "master" {
  value = aws_instance.master.id
}

output "slave1" {
  value = aws_instance.slave1.id
}

output "slave2" {
  value = aws_instance.slave2.id
}