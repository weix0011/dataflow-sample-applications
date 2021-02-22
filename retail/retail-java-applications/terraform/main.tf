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

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.48.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "pubsub" {
  source                     = "./modules/pubsub"
  topic_clickstream_inbound  = var.topic_clickstream_inbound
  topic_transactions_inbound = var.topic_transactions_inbound
  topic_inventory_inbound    = var.topic_inventory_inbound
  topic_inventory_outbound   = var.topic_inventory_outbound
  clickstream_inbound_sub    = var.clickstream_inbound_sub
  transactions_inbound_sub   = var.transactions_inbound_sub
  inventory_inbound_sub      = var.inventory_inbound_sub
}

module "bigquery" {
  source                                     = "./modules/bigquery"
  bq_dataset_id_retail_store                 = var.bq_dataset_id_retail_store
  bq_friendly_name_retail_store              = var.bq_friendly_name_retail_store
  bq_table_id_store_locations                = var.bq_table_id_store_locations
  bq_dataset_id_retail_store_aggregations    = var.bq_dataset_id_retail_store_aggregations
  bq_friendly_name_retail_store_aggregations = var.bq_friendly_name_retail_store_aggregations
}
