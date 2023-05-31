variable "name" {}

variable "address_space" {}

variable "rg" {
  type = object({
    name     = string
    location = string
  })
}

variable "peering_connections" {
  type = map(object({
    id = string
  }))
}

variable "dns_servers" {
  default = []
}