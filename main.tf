resource "azurerm_resource_group" "demorg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_storage_account" "demostorage7799" {
  name                     = "co${var.domain}us6${var.prefix}sac01"
  resource_group_name      = azurerm_resource_group.demorg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "devtest"
  }
}

resource "azurerm_storage_container" "democontainer" {
  name                  = "democontainer"
  storage_account_name  = azurerm_storage_account.demostorage7799.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "uploadfile" {
  name                   = "${var.prefix}file1"
  storage_account_name   = azurerm_storage_account.demostorage7799.name
  storage_container_name = azurerm_storage_container.democontainer.name
  type                   = "Block"
  source                 = "providers.tf"
}
