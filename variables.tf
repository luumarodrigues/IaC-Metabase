variable "private_key" {
  description = "Path to the SSH private key to be used for authentication"
  default = "~/.ssh/key.pem"
}

variable "public_key" {
  description = "Path to the SSH public key to be used for authentication"
  default = "~/.ssh/key.pub"
}

variable "region" {
  default = "us-east-1"
  description = "AWS region to launch servers"
}

variable "instance_type" {
  type        = "string"
  description = "The type of instance to start"
  default     = "t2.micro"
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = true
}

variable "tags" {
  type        = "map"
  description = "A mapping of tags to assign to the resource"

  default = {
    "Name"     = "Ubuntu"
    "Ambiente" = "Desenvolvimento"
    "Projeto"  = "DevOps-metabase"
  }
}
