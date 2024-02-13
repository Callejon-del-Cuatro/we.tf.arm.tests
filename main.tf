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

#resource "azurerm_network_interface" "nic_we" {
#  name                = "nicweu84b1"
#  location            = azurerm_resource_group.rg_we.location
#  resource_group_name = azurerm_resource_group.rg_we.name

#  ip_configuration {
#    name                          = "example-config"
#    subnet_id                     = azurerm_subnet.example.id
#    private_ip_address_allocation = "Dynamic"
#  }
#}

#resource "azurerm_linux_virtual_machine" "example" {
#  name                = "example-vm"
#  resource_group_name = azurerm_resource_group.example.name
#  location            = azurerm_resource_group.example.location
#  size                = "Standard_D2s_v3"
#  admin_username      = "adminuser"
#  network_interface_ids = [
#    azurerm_network_interface.example.id,
#  ]

#  admin_ssh_key {
#    username   = "adminuser"
#    public_key = file("~/.ssh/id_rsa.pub") # Cambia la ruta según tu clave pública SSH
#  }

#  source_image_reference {
#    publisher = "Canonical"
#    offer     = "UbuntuServer"
#    sku       = "20.04-LTS"
#    version   = "latest"
#  }
#}
