# Hiive SRE - Datadog Monitors as Code

Terraform configuration for the **top 5 most important Datadog monitors** for the Hiive platform.

## Monitors Included

| Monitor                          | Type          | Severity     | Purpose                              |
|----------------------------------|---------------|--------------|--------------------------------------|
| GraphQL 5xx Error Rate           | Log Alert     | **Critical** | Detect application errors            |
| DBConnection Pool Exhaustion     | Log Alert     | **Critical** | Database connection issues           |
| RDS CPU Utilization              | Metric Alert  | High         | Database health                      |
| GraphQL p99 Latency              | Metric Alert  | High         | API performance                      |
| Hiive Pod Restarts               | Metric Alert  | High         | Kubernetes pod stability             |

## How to Deploy

1. Copy the example variables:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
