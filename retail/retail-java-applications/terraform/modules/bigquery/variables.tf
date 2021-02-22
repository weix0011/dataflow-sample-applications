/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
variable "bq_dataset_id_retail_store" {
  type        = string
  description = "BigQuery dataset ID for retail store"
}

variable "bq_dataset_id_retail_store_aggregations" {
  type        = string
  description = "BigQuery dataset ID for retail store aggregations"
}

variable "bq_table_id_store_locations" {
  type        = string
  description = "BigQuery table ID for store locations"
}

variable "bq_friendly_name_retail_store" {
  type        = string
  description = "BigQuery friendly name for retail store"
}

variable "bq_friendly_name_retail_store_aggregations" {
  type        = string
  description = "BigQuery friendly name for retail store aggregations"
}
