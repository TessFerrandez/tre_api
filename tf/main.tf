provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "fastapi_rg"{
  name = "fastapi-rg"
  location = "westeurope"
}

resource "azurerm_app_service_plan" "api_service_plan" {
  location = "westeurope"
  name = "treapi-1234"
  resource_group_name = "fastapi-rg"
  kind = "linux"
  reserved = true
  sku {
    size = "F1"
    tier = "Free"
  }
}

resource "azurerm_app_service" "api_app_service" {
  app_service_plan_id =  "/subscriptions/47c53038-ea3d-4516-b6e8-875e26227fed/resourceGroups/fastapi-rg/providers/Microsoft.Web/serverfarms/treapi-1234"
  app_settings = {"SCM_DO_BUILD_DURING_DEPLOYMENT" = "1"}
  # client_affinity_enabled = false
  # client_cert_enabled = false
  # enabled = true
  https_only = false
  location = "westeurope"
  name = "treapi1234"
  resource_group_name = "fastapi-rg"
  site_config {
    always_on = false
    app_command_line = "gunicorn -w 4 -k uvicorn.workers.UvicornWorker api.main:app"
    linux_fx_version = "PYTHON|3.8"
    # managed_pipeline_mode = "Integrated"
    # min_tls_version = "1.2"
    # number_of_workers = 1
    use_32_bit_worker_process = true
  }
  source_control {
    branch             = "main"
    repo_url           = "https://github.com/TessFerrandez/tre_api"
  }
}
