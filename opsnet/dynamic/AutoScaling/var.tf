variable "vpc_id" {
  default = "vpc-06bded5f3b5fbaae5"
}

variable "public_subnet_name"{
  default = ["ALB&NAT", "ALB"]
}

variable "private_subnet_name"{
  default = ["WebServer-A", "WebServer-C", "DBMS-A", "DBMS-C", "Window"]
}