variable cosmosdb {
  default     = "tollboothdb35"
}
variable resource_group_name {
}

variable location {
}

variable failover_location {
  default = "japanwest"
}

variable sql_database {
  default     = "LicensePlates"
}

variable sql_container_processed {
  default     = "Processed"
}

variable sql_container_NeedsManualReview {
  default     = "NeedsManualReview"
}

variable c1_partitionkey {
  default     = "/licensePlateText"
}

variable c2_partitionkey {
  default     = "/fileName"
}
