variable "env" {
  description = "Environment name"
}

variable "ssh_key" {
  description = "Key pair to access the EC2 instance"
}

variable "app_name" {
  description = "Application name"
}

variable "aws_region" {
  description = "AWS region"
}

provider "aws" {
  region     = "${var.aws_region}"
}

resource "aws_ecr_repository" "app" {
  name = "${var.app_name}"
}

output "ecr_repo" {
  value = "${aws_ecr_repository.app.name}"
}
