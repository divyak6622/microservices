#!/usr/bin/env bash

ENV_FOLDER=$(pwd)/envs/$1
APP=$2

ECR_URI=$(aws ecr describe-repositories --repository-names "$APP" | jq -r .repositories[0].repositoryUri)

cd $ENV_FOLDER/infrastructure
terraform get
terraform plan -var-file="$ENV_FOLDER/input.tfvars"