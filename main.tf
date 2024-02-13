resource "azurerm_resource_group" "rg_we" {
  name     = "rgweu84b1"
  location = "West Europe"
}

resource "azurerm_virtual_network" "net_we" {
  name                = "netweu84b1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_we.location
  resource_group_name = azurerm_resource_group.rg_we.name
}

resource "azurerm_subnet" "snt_we" {
  name                 = "sntweu84b1"
  resource_group_name  = azurerm_resource_group.rg_we.name
  virtual_network_name = azurerm_virtual_network.net_we.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic_we" {
  name                = "nicweu84b1"
  location            = azurerm_resource_group.rg_we.location
  resource_group_name = azurerm_resource_group.rg_we.name

  ip_configuration {
    name                          = "ipc_we"
    subnet_id                     = azurerm_subnet.snt_we.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm_we" {
  name                = "vmweu84b1-00"
  resource_group_name = azurerm_resource_group.rg_we.name
  location            = azurerm_resource_group.rg_we.location
  size                = "Standard_B2s_v2"
  admin_username      = "quijote"
  admin_password      = "${var.admin_password}"
  network_interface_ids = [
    azurerm_network_interface.nic_we.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
