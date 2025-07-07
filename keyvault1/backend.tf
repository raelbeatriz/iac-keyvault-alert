terraform {
  backend "azurerm" {
    resource_group_name  = "az-eun-ddc-rg-tf-dxp-mgmt"
    storage_account_name = "azeunddcstdxpmgmt"
    container_name       = "dxpsecretalert"
    key                  = "azweuglkvdevdxpcore-secret-alert.terraform.tfstate"
  }
}
