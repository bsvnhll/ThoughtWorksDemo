This repo contains the scripts used to create the infrastructure in Azure which includes
Application gateway and Azure kubernates cluster and Kubernates configurations.

### Tooling pre-requisites


The following tools are required to manipulate the Azure infrastructure with the
scripts in this repo:

* [Terraform](https://www.terraform.io/downloads.html) (`> choco install Terraform -y`)

### Azure authentication

There are a number of approaches for handling authentication with Azure which are
documented here [Azure Provider for Terraform](https://www.terraform.io/docs/providers/azurerm/index.html)

### Environment structure

Current project is structured as components, modules and groupvars
Componets containes scripts for creating Azure application gateway component, AKS cluster
It also, containes all the kubernates configs for creatig application gateway as ingress controller, kubernates ingress,  kubernates service and Deployments for MediaWiki and mysql DB.

teraform scripts for creating kubernetes cluster in Azure are in this path - ## components\coupon_app

Kubernetes configuration files are at - ### components\kubernetes

All the variable files are at ### components\group_vars

pipeline.yaml files are Azure devops yaml files can be run in Azure devops CI tool. 

Azure storage account  - is used for storing terraform state files.

We use Azure vault service for securly storing secrets, which are used during provisioning resources in Azure
We use Service principal account to authenticate againest Azure cloud.


### Azure Devops CI tool

We use azure devops portal as CI tool, which can be accessed with the below URL
https://dev.azure.com
We have created Origanization in Azure devops, and under that there are multiple projects for dev, PPE and PROD environments can be created.
