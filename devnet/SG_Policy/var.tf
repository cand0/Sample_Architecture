variable "dev_vpc_id" {
  default = "vpc-083e74f4f28c5645d"
}

variable "dev_public_subnet_name"{
  default = ["dev_ALB&NAT", "dev_ALB"]
}

variable "dev_private_subnet_name"{
  default = ["dev_WebServer-A", "dev_WebServer-C", "dev_DBMS-A", "dev_DBMS-C"]
}