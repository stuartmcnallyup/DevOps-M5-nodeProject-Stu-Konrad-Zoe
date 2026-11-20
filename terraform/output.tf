output "ec2_ci_ssh_cmd" {
  value = module.ec2_ci.ssh_command
}

output "ec2_deployment_ssh_cmd" {
  value = module.ec2_deployment.ssh_command
}
