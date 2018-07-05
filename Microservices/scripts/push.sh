#!/usr/bin/env bash

ENV_FOLDER=$(pwd)/envs/$1
APP=$2

cd $ENV_FOLDER/ecr
terraform get
terraform apply -var-file="$ENV_FOLDER/input.tfvars"

ECR_URI=$(aws ecr describe-repositories --repository-names "$APP" | jq -r .repositories[0].repositoryUri)

$(aws ecr get-login)

docker tag "$APP" "$ECR_URI":latest
docker push "$ECR_URI":latest
