variable "vpc_cidr" {
    default = "10.0.0.0/16"
}


variable "enable_dns_hostnames" {
    default ="true" 
}


variable "preferred_number_of_public_subnets" {
      default = null
}

variable "preferred_number_of_private_subnets" {
      default = null
}

variable "public_route_table_cidr" {
  default = "string"

}

variable "preferred_number_of_elastic_ip" {
  default = null
}

variable "preferred_number_of_nat"{
  default = null
}

variable "preferred_number_of_private_subnets_association" {
  default = null
}

variable "ip_address_type" {
  default = "string"
}

variable "load_balancer_type" {
  default = "string"
}

variable "keypair" {
  default = "string"
}
