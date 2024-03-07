terraform {
  backend "azurerm" {
    resource_group_name  = "test-rg"
    storage_account_name = "teststorage123"
    container_name       = "devtest-tfstate"
    key                  = "devtest.terraform.tfstate"
  }
}
