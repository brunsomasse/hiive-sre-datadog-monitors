variable "datadog_api_key" {
  type        = string
  sensitive   = true
  description = "Datadog API Key"
}

variable "datadog_app_key" {
  type        = string
  sensitive   = true
  description = "Datadog App Key"
}
