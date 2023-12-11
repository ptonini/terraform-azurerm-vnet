resource "azurerm_virtual_network" "this" {
  name                = var.name
  address_space       = var.address_space
  location            = var.rg.location
  resource_group_name = var.rg.name
  dns_servers         = var.dns_servers
  lifecycle {
    ignore_changes = [
      tags["business_unit"],
      tags["environment"],
      tags["product"],
      tags["subscription_type"],
      tags["environment_finops"]
    ]
  }
}

resource "azurerm_virtual_network_peering" "this" {
  for_each                  = var.peering_connections
  name                      = each.key
  resource_group_name       = var.rg.name
  virtual_network_name      = azurerm_virtual_network.this.name
  remote_virtual_network_id = each.value["id"]
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
  use_remote_gateways       = var.peering_use_remote_gateways
}