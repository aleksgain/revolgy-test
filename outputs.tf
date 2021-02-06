output "vpc_id" {
  value = aws_vpc.app-vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "alb_url" {
  value = "http://${aws_alb.revolgy-test.dns_name}"
}

output "ip" {
  value = aws_eip.nat.public_ip
}

output "database_endpoint" {
  value = module.db.this_db_instance_address
}