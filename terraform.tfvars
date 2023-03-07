region = "us-east-1"

vpc_cidr = "10.0.0.0/16" 

enable_dns_hostnames = "true"  

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

preferred_number_of_elastic_ip = 2

preferred_number_of_nat = 2

public_route_table_cidr = "0.0.0.0/0"

ip_address_type = "ipv4"

load_balancer_type = "application"
