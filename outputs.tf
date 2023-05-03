output "instance_id" {
  description = "Instance ID"
  value       = aws_instance.mirroring.id
}

output "instance_public_ip" {
  description = "Public IP address of the VM"
  value       = aws_instance.mirroring.public_ip
}

output "lb_public_ip" {
  description = "Public IP address of the load balancer"
  value       = aws_eip.lb.public_ip
}