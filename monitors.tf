# 1. GraphQL 5xx Error Rate
resource "datadog_monitor" "graphql_5xx_errors" {
  name    = "[Critical] GraphQL 5xx Error Rate"
  type    = "log alert"
  message = <<EOT
Critical: High 5xx error rate on GraphQL.

@slack-sre @pagerduty
EOT

  query = "logs('service:hiive status:error OR http.status_code:5*').index('*').rollup('count').by('@http.url_details.path').last('5m') > 10"

  monitor_thresholds {
    critical = 10
  }

  tags = ["env:prod", "service:hiive", "severity:critical"]
}

# 2. DBConnection Pool Exhaustion
resource "datadog_monitor" "db_connection_pool_exhaustion" {
  name    = "[Critical] DBConnection.ConnectionError - Pool Exhaustion"
  type    = "log alert"
  message = <<EOT
Critical: Database connection pool exhaustion detected.

@slack-sre @pagerduty
EOT

  query = "logs('DBConnection.ConnectionError').index('*').rollup('count').last('1m') > 5"

  monitor_thresholds {
    critical = 5
  }

  tags = ["env:prod", "service:hiive", "severity:critical"]
}

# 3. RDS CPU High
resource "datadog_monitor" "rds_cpu_high" {
  name    = "[High] RDS CPU Utilization High"
  type    = "metric alert"
  message = <<EOT
High: RDS CPU is elevated.

@slack-sre
EOT

  query = "avg(last_10m):avg:aws.rds.cpuutilization{env:prod} > 85"

  monitor_thresholds {
    warning  = 75
    critical = 85
  }

  tags = ["env:prod", "severity:high"]
}

# 4. GraphQL p99 Latency
resource "datadog_monitor" "graphql_p99_latency" {
  name    = "[High] GraphQL p99 Latency > 5s"
  type    = "metric alert"
  message = <<EOT
High: GraphQL p99 latency above 5 seconds.

@slack-sre
EOT

  query = "max(last_5m):p99:trace.graphql.server.duration{env:prod,service:hiive} > 5000"

  monitor_thresholds {
    warning  = 3000
    critical = 5000
  }

  tags = ["env:prod", "severity:high"]
}

# 5. Pod Restarts
resource "datadog_monitor" "pod_restarts" {
  name    = "[High] Hiive Pod Restarts"
  type    = "metric alert"
  message = <<EOT
High: Pods restarting in Hiive namespace.

@slack-sre
EOT

  query = "avg(last_10m):sum:kubernetes.containers.restarts{namespace:hiive} by {pod_name} > 2"

  monitor_thresholds {
    critical = 2
  }

  tags = ["env:prod", "severity:high"]
}
