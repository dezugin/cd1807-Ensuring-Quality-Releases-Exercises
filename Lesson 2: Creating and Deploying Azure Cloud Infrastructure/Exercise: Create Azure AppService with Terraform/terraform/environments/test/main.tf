provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "tfstate2571717897"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
    access_key           = "utXuVyG6v2/U44+zkyK7AETEL8w4+wImjB/6M+qEmpvYcpswu+0YOzsGIproaGGa/Nn8cw5rg5rE+AStk6tEaA=="
  }
}
locals {
  tags = {
    tier        = "${var.tier}"
    deployment  = "${var.deployment}"
  }
}
module "resource_group" {
  source               = "../../modules/resource_group"
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
}
# Reference the AppService Module here.
module "appservice" {
  source           = "../../modules/appservice"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "AppService"
  resource_group   = "${module.resource_group.resource_group_name}"
  tags             = "${local.tags}"
}