module "appgateway" {
  source = "../dev-env-modules/appgateway_loadbalancer"

  rg_name              = data.azurerm_resource_group.vm_rg.name
  location             = "East US"
  appgw_name           = "dev-appgw"
  subnet_id            = module.my_network.subnet_ids["appgw-subnet"]
  backend_ip_addresses = module.vm_machines.vm_private_ips
  create_resource      = true
}

output "appgw_id" {
  value = module.appgateway.appgw_id
}

output "appgw_name" {
  value = module.appgateway.appgw_name
}

output "appgw_public_ip" {
  value = module.appgateway.public_ip_address
}
