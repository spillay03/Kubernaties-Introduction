
# Add output variables
output "public_ip" {
  value = aws_instance.linux_vm.public_ip
}