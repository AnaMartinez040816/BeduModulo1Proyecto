#Definimos el resource group a crear

resource "azurerm_resource_group" "core" {
    name = "proyectoTerraform"
    location = var.location
}

resource "azurerm_service_plan" "core" {
    name = "Ejemplo01"
    resource_group_name = azurerm_resource_group.core.name
    location = var.location
    os_type = "Windows"
    sku_name = "P1V2"
}

#resource "azurerm_windows_web_app" "core" {
#    name                 = "app-terraformplan"
#    resource_group_name  = azurerm_resource_group.core.name 
#    location             = azurerm_service_plan.core.location 
#    service_plan_id      = azurerm_service_plan.core.id  

#    site_config {}
#}

resource "azurerm__mssql_server" "core" {
    name = "sql-terraform-talk"
    resource_group_name = azurerm_resource_group.core.name
    location = azurerm_resource_group.core.location 
    version = "12.0"
    administrator_login = "missadministrator"
    administrator_login_password = "thisIsKAt11"
    minimun_tls_version = "1.2"
}

resource "azurerm_mssql_database" "core" {
 name = "sqldb-terraform-talk"
 server_id = azurerm__mssql_server.core.id 
 collation = "SQL_Latin1_General_CP1_CI_AS"
 license_type = "LicenceIncluded"
 max_size_gb = 2
 sku_name = "Basic"
 zone_redundant = false
}

resource "azurerm_key_vault" "core" {
    name = "kv-terraform-talk"
    location = azurerm_resource_group.core.location 
    resource_group_name = azurerm_resource_group.core.name 
    enabled_for_disk_encryption = true 
    tenant_id = data.azurerm_client_config_current_tenant_id
    soft_delete_retention_days = 2
    purge_protection_enabled = false

    sku_name = "standard"

    depends_on = [
        azurerm_mssql_database.core 
    ]

    lifecycle {
        ignore_changes = [
            tags 
        ]
    }
}

