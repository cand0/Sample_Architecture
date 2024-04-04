variable "dev_subnet_cidrs_public" {
  description = "Subnet CIDRs for public subnets (length must match configured availability_zones)"
  default = ["192.169.11.0/24", "192.169.12.0/24"]
}

variable "dev_subnet_cidrs_private" {
  description = "Subnet CIDRs for public subnets (length must match configured availability_zones)"
  default = ["192.169.1.0/24", "192.169.2.0/24", "192.169.3.0/24", "192.169.4.0/24"]
}

variable "dev_availability_zones" {
  default = ["ap-northeast-1a","ap-northeast-1c", "ap-northeast-1a","ap-northeast-1c", "ap-northeast-1a"]
}

variable "dev_public_subnet_name"{
  default = ["dev_ALB&NAT", "dev_ALB"]
}

variable "dev_private_subnet_name"{
  default = ["dev_WebServer-A", "dev_WebServer-C", "dev_DBMS-A", "dev_DBMS-C"]
}