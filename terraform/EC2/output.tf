output "public_ip" {
  value = aws_instance.vm01.public_ip
}

output "ssh_command" {
  value = "ssh -i lab5-key.pem ubuntu@${aws_instance.vm01.public_ip}"
}
