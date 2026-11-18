output "security_group_id" {
  description = "Default/Jump-Server Security Group ID for backward compatibility"
  value       = aws_security_group.Jump-Server.id
}

output "jump_server_sg_id" {
  description = "Jump-Server Security Group ID"
  value       = aws_security_group.Jump-Server.id
}

output "web_frontend_alb_sg_id" {
  description = "Web Frontend ALB Security Group ID"
  value       = aws_security_group.web_frontend_alb.id
}

output "web_srv_sg_id" {
  description = "Web Server Security Group ID"
  value       = aws_security_group.web_srv.id
}

output "app_internal_alb_sg_id" {
  description = "Internal App ALB Security Group ID"
  value       = aws_security_group.app_internal_alb.id
}

output "app_srv_sg_id" {
  description = "App Server Security Group ID"
  value       = aws_security_group.app_srv.id
}

output "db_srv_sg_id" {
  description = "Database Server Security Group ID"
  value       = aws_security_group.db_srv.id
}
