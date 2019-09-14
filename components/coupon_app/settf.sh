#!/bin/bash
option=$1
region=$2
env=$3
plan=$4



if [ "$#" == 0 ]; then
    echo "Help:"
    echo "settf.sh <option: create | destroy <Azure Region: region>  <Environment: env>"
    echo "ex: ./settf.sh create westeurope dev"
    echo "ex: ./settf.sh destroy westeurope dev"
    exit 1
fi

create(){

  #Initialize terraform
  terraform init -backend-config="../../group_vars/${env}/backend_config_${region}.tfvars" \
                 -backend-config="key=aks.${region}.${env}.terraform.tfstate"

  if [ "$?" != "0" ]; then
      echo "Failed to initialize terraform"
      exit 1
  fi

  terraform plan -out out.terraform  -var-file="../../group_vars/${env}/${region}.tfvars"
  if [ "$?" != "0" ]; then
      echo "Failed to plan terraform"
      exit 1
  fi

  if [ $plan != true ]; then
  terraform apply out.terraform
    if [ "$?" != "0" ]; then
      echo "Failed to apply terraform"
      exit 1
    fi
  fi
  echo "Creation of k8s complete!!"
}

destroy(){

  #Initialize terraform
  terraform init -backend-config="../../group_vars/${env}/backend_config_${region}.tfvars" \
                 -backend-config="key=aks.${region}.${env}.terraform.tfstate"

  terraform plan -destroy -var-file="../../group_vars/${env}/${region}.tfvars"

  # Destroy the base environment
  if [ $plan != true ]; then
  terraform destroy -var-file="../../group_vars/${env}/${region}.tfvars" -auto-approve
  fi
}


if [ "$option" == "create" ]; then
  create
elif [ "$option" == "destroy" ]; then
  destroy
else
  echo "Invalid option '$option'. Please try with a valid option (see help)"
fi
