 variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "project-vpc"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "172.31.0.0/16"
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
  default     = "vpc-0503062b0ba09a080"
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["subnet-09d4e5ff600546739", "subnet-087d21dff07c6c7ae", "subnet-03cbd57d86dd72729"]
}



variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  
}

variable "instance_type" {
    type = map(string)
    default = {
        dev = "t2.micro"
        prod = "t2.large"
        testing = "t2.medium"
    }
  
}


