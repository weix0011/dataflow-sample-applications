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

variable "project_id" {
  type        = string
  description = "Project ID in GCP"
}

variable "region" {
  type        = string
  description = "Name of the selected region"
}

variable "topic_clickstream_inbound" {
  type        = string
  description = "Topic name for clickstream inbound"
}

variable "topic_transactions_inbound" {
  type        = string
  description = "Topic name for transactions inbound"
}

variable "topic_inventory_inbound" {
  type        = string
  description = "Topic name for inventory inbound"
}

variable "topic_inventory_outbound" {
  type        = string
  description = "Topic name for inventory outbound"
}

variable "clickstream_inbound_sub" {
  type        = string
  description = "Subscription for clickstream inbound"
}

variable "transactions_inbound_sub" {
  type        = string
  description = "Subscription for transactions inbound"
}

variable "inventory_inbound_sub" {
  type        = string
  description = "Subscription for inventory inbound"
}

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
