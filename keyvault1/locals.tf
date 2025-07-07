locals {
  tags = {
    cloud               = "Azure"
    country             = "DDC"
    market              = "global"
    platform            = "DXP"
    department          = "DXP1"
    environment         = "dev"
    geographic_location = "weu"
    project_description = "DXP Expiration Alert"
    project_name        = "dxp-expiration-alert"
    project_owner       = "tbd"
    solution_name       = "tbd"
    cost_center         = "devops"
    source              = "terraform"
  }

rg_name   = "az-weu-gl-rg-dev-dxp-core-01"
kv_name   = "azweuglkvdevdxpcore"
law_name  = "az-eun-ddc-log-dxp-mgmt"
law_rg    = "az-eun-ddc-rg-tf-dxp-mgmt"

#diagnostic setting
ds_name   = "expiration-alert"

#action group
ag_name           = "expiration-alert"
ag_short_name     = "Alert"
email_addresses = {
  "sendtogustavo"  = ""
  "sendtojacque"   = ""
  "sendtorael"     = ""
  "sendtocyril"    = ""
  "sendtojaime"    = ""
  "sendtokevin"    = ""
  "sendtoangelo"   = ""
  "sendtojaime2"   = ""
  "sendtoyesid"    = ""
}

#alert rule (secret)
ar_name_secret               = "expiring-secret"
evaluation_frequency_secret  = "P1D"
window_duration_secret       = "P1D"
severity_secret              = 3
description_secret           = "Expiring Secret"
display_name_secret          = "expiring-secret"

#alert rule (key)
ar_name_key               = "expiring-key"
evaluation_frequency_key  = "P1D"
window_duration_key       = "P1D"
severity_key              = 3
description_key           = "Expiring Key"
display_name_key          = "expiring-key"

#alert rule (certificate)
ar_name_cert                = "expiring-certificate"
evaluation_frequency_cert   = "P1D"
window_duration_cert        = "P1D"
severity_cert               = 3
description_cert            = "Expiring Certificate"
display_name_cert           = "expiring-certificate"
}
