output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

# Output all subnet IDs as a map
output "subnet_ids" {
  value       = { for key, subnet in aws_subnet.subnets : key => subnet.id }
  description = "Map of all subnet IDs"
}

# Output individual subnet IDs for backward compatibility
output "public_subnet_az1_id" {
  value = aws_subnet.subnets["public-subnet-az1"].id
}

output "public_subnet_az2_id" {
  value = aws_subnet.subnets["public-subnet-az2"].id
}

output "private_app_subnet_az1_id" {
  value = aws_subnet.subnets["private-app-subnet-az1"].id
}

output "private_app_subnet_az2_id" {
  value = aws_subnet.subnets["private-app-subnet-az2"].id
}

output "private_data_subnet_az1_id" {
  value = aws_subnet.subnets["private-data-subnet-az1"].id
}

output "private_data_subnet_az2_id" {
  value = aws_subnet.subnets["private-data-subnet-az2"].id
}

output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}