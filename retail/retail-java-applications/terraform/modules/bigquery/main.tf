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

//enable bigquery API
resource "google_project_service" "bigquery" {
  service            = "bigquery.googleapis.com"
  disable_on_destroy = false
}

//create bigquery resources
resource "google_bigquery_dataset" "bq_dataset_retail_store" {
  dataset_id                  = var.bq_dataset_id_retail_store
  friendly_name               = var.bq_friendly_name_retail_store
  description                 = "This is a test description"
  location                    = "US"
  
  delete_contents_on_destroy  = true

  labels = {
    env = "default"
  }
}

resource "google_bigquery_table" "bq_table" {
  dataset_id = google_bigquery_dataset.bq_dataset_retail_store.dataset_id
  table_id   = var.bq_table_id_store_locations

  time_partitioning {
    type  = "DAY"
  }

  labels = {
    env = "default"
  }
  schema = file("${path.module}/store-locations-bq-schema.json")
}

resource "google_bigquery_dataset" "bq_dataset_retail_store_aggregations" {
  dataset_id                  = var.bq_dataset_id_retail_store_aggregations
  friendly_name               = var.bq_friendly_name_retail_store_aggregations
  description                 = "This is a test description"
  location                    = "US"
  
  delete_contents_on_destroy  = true

  labels = {
    env = "default"
  }
}
