variable "subnet_cidrs_public" {
  description = "Subnet CIDRs for public subnets (length must match configured availability_zones)"
  default = ["192.168.11.0/24", "192.168.12.0/24"]
}

variable "subnet_cidrs_private" {
  description = "Subnet CIDRs for public subnets (length must match configured availability_zones)"
  default = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24", "192.168.5.0/24"]
}

variable "availability_zones" {
  default = ["ap-northeast-1a","ap-northeast-1c", "ap-northeast-1a","ap-northeast-1c", "ap-northeast-1a","ap-northeast-1c"]
}

variable "public_subnet_name"{
  default = ["ALB&NAT", "ALB"]
}

variable "private_subnet_name"{
  default = ["WebServer-A", "WebServer-C", "DBMS-A", "DBMS-C", "Window"]
}