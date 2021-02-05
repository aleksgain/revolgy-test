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
  value = aws_eip.ip.public_ip
}