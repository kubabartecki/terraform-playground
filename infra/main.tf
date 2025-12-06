provider "azurerm" {
  features {}
  # az account list
  subscription_id = ""
}

resource "azurerm_resource_group" "main" {
  name     = "terra-rg"
  location = "polandcentral"
}

###################### db ######################

resource "azurerm_postgresql_flexible_server" "db-server" {
  name                   = "terra-psqlflexibleserver"
  resource_group_name    = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  version                = "16"
  administrator_login    = "postgres"
  administrator_password = "todo"
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
  public_network_access_enabled = true
  
  lifecycle {
    ignore_changes = [ zone ]
  }
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = "terra-db"
  server_id = azurerm_postgresql_flexible_server.db-server.id
  collation = "en_US.utf8"
  charset   = "utf8"
  
  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure_services" {
  name                = "allow-azure-services"
  server_id           = azurerm_postgresql_flexible_server.db-server.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255" # todo
}



###################### container registry ######################
resource "azurerm_container_registry" "acr" {
  name                = "terracr"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true
}

###################### Container app environment ######################
resource "azurerm_container_app_environment" "container_app_environment" {
  name                       = "terra-container-app-environment"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
}

###################### backend ######################
resource "azurerm_container_app" "backend" {
  name                         = "terra-back"
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  resource_group_name          = azurerm_resource_group.main.name
  revision_mode                = "Single"
  
  template {
    container {
      name   = "terra-back-container"
      image  = "${azurerm_container_registry.acr.login_server}/terra-back:v1.0"
      cpu    = 1.0
      memory = "2.0Gi"

      env {
        name  = "SPRING_PROFILES_ACTIVE"
        value = "azure"
      }
      env {
        name  = "DB_URL"
        value = "jdbc:postgresql://${azurerm_postgresql_flexible_server.db-server.fqdn}:5432/terra-db"
      }
      env {
        name  = "DB_USERNAME"
        value = "postgres"
      }
      env {
          name  = "DB_PASSWORD"
          value = "todo"
      } 
    }
  }

  secret {
    name  = "acr-password-secret"
    value = azurerm_container_registry.acr.admin_password
  }

  registry {
    server   = azurerm_container_registry.acr.login_server
    username = azurerm_container_registry.acr.admin_username
    password_secret_name = "acr-password-secret"
  }

  ingress {
      external_enabled = true   # public access
      target_port      = 8080    # Expose the backend on port 8080
      
      traffic_weight {
        latest_revision = true
        percentage = 100
      }
  }
}

###################### frontend ######################

resource "azurerm_container_app" "frontend" {
  name                         = "terra-front"
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  resource_group_name          = azurerm_resource_group.main.name
  revision_mode                = "Single"

  template {
    container {
      name   = "terra-front-container"
      image  = "${azurerm_container_registry.acr.login_server}/terra-front:v1.0"
      cpu    = 1.0
      memory = "2.0Gi"

      env {
        name  = "REACT_APP_API_URL"
        value = "https://${azurerm_container_app.backend.ingress[0].fqdn}/api/v1/terra"
      }
    }
  }

  secret {
    name  = "acr-password-secret"
    value = azurerm_container_registry.acr.admin_password
  }

  registry {
    server   = azurerm_container_registry.acr.login_server
    username = azurerm_container_registry.acr.admin_username
    password_secret_name = "acr-password-secret"
  }
    ingress {
      external_enabled = true
      target_port      = 3000
      
      traffic_weight {
        latest_revision = true
        percentage = 100
      }
  }
}
