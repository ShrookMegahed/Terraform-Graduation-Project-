variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "enable_dns_support" {
    default = "true"
}

variable "enable_dns_hostnames" {
    default ="true" 
}

variable "enable_classiclink" {
    default = "false"
}

variable "enable_classiclink_dns_support" {
    default = "false"
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

variable "ip_address_type" {
  default = "string"
}

variable "load_balancer_type" {
  default = "string"
}
