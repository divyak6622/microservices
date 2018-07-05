variable "env" {
  description = "Environment name"
}

variable "ssh_key" {
  description = "Key pair to access the EC2 instance"
}

variable "app_name" {
  description = "Application name"
}

variable "port" {
  description = "Application port"
}

variable "dns_name" {
  description = "DNS name"
}

variable "image_name" {
  description = "Docker image name"
}

variable "aws_region" {
  description = "AWS region"
}

provider "aws" {
  region     = "${var.aws_region}"
}

module "stack" {
  source      = "github.com/segmentio/stack"
  environment = "${var.env}"
  key_name    = "${var.ssh_key}"
  name        = "${var.app_name}"
}

module "app" {
  # this sources from the "stack//service" module
  source          = "github.com/segmentio/stack/service"
  dns_name        = "${var.dns_name}"
  name            = "${var.app_name}"
  image           = "${image_name}"
  port            = "${port}"
  environment     = "${module.stack.environment}"
  cluster         = "${module.stack.cluster}"
  iam_role        = "${module.stack.iam_role}"
  security_groups = "${module.stack.internal_elb}"
  subnet_ids      = "${module.stack.internal_subnets}"
  log_bucket      = "${module.stack.log_bucket_id}"
  zone_id         = "${module.stack.zone_id}"
}