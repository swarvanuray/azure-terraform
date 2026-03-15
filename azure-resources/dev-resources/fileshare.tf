module "my_fileshare" {
  source = "../dev-env-modules/fileshare"

  # Existing storage account where the Azure File Share will be created.
  storage_account_name = "swarvanu" # REPLACE THIS with your existing Storage Account name
  share_name           = "swarvanu-linux-share"

  quota            = 100
  enabled_protocol = "SMB"

  # Feature flags
  create_resource   = true
  create_share_file = false

  # Optional file upload settings (used only when create_share_file = true)
  file_name         = "linux-init.txt"
  source_file       = ""
  file_path         = ""
  file_content_type = "text/plain"
}

output "fileshare_id" {
  value = module.my_fileshare.fileshare_id
}

output "fileshare_name" {
  value = module.my_fileshare.fileshare_name
}

output "share_file_id" {
  value = module.my_fileshare.share_file_id
}
