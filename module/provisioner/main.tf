resource "azurerm_resource_group" "example" {
  name     = "rgvm"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "vnetvm"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_public_ip" "publicipvm" {
  name                = "vmpip"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_network_security_group" "example" {
  name                = "nsgvm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "test121"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "test123"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}
resource "azurerm_network_interface" "example" {
  name                = "nicvm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicipvm.id
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                            = "vm"
  resource_group_name             = azurerm_resource_group.example.name
  location                        = azurerm_resource_group.example.location
  size                            = "Standard_F2"
  admin_username                  = "shivam18267"
  admin_password                  = "ril@2024"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.example.id, ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  connection {
    host     = self.public_ip_address
    user     = "shivam18267"
    password = "ril@2024"
    type     = "ssh"
    timeout  = "2m"
  }

    provisioner "file" {
        source = "index.html"
        destination = "/tmp/index.html"
    }

    provisioner "remote-exec" {
      inline = [ "sudo apt update","sudo apt install nginx -y","sudo cp /tmp/index.html /var/www/html",
    
       ]
    }

    provisioner "local-exec" {
      command = "echo I Love India > shivam.txt"
    }
}