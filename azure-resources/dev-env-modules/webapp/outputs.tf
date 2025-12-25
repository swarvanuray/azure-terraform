output "webapp_ids" {
  # Return a Map: "app_name" => "app_id"
  value = { for k, v in azurerm_linux_web_app.this : k => v.id }
}

output "webapp_urls" {
  value = [for app in azurerm_linux_web_app.this : "https://${app.default_hostname}"]
}