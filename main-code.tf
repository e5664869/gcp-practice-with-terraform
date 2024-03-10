terraform {
  backend "gcs" {
    bucket = "terraform-state-gcp-backend"
    prefix  = "terraform/state"
    credentials = "my-gcp-key.json"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  credentials = file("my-gcp-key.json")
  region      = var.provider-region
  project     = var.gcp-project
}

locals {
  subnets  = ["private1", "private2"]
  subnets2 = ["public1", "public2"]
}
resource "google_compute_network" "my-custom" {
  name                            = var.vpc-name
  delete_default_routes_on_create = false
  auto_create_subnetworks         = false
  routing_mode                    = "REGIONAL"
}
resource "google_compute_subnetwork" "my-custom-private" {
  count                    = 2
  name                     = "${var.private-subnet-name}-${local.subnets[count.index]}"
  ip_cidr_range            = var.private-subnet-cidir-range[count.index]
  region                   = var.private-subnet-region[count.index]
  private_ip_google_access = true
  network                  = google_compute_network.my-custom.id
  depends_on               = [google_compute_network.my-custom]
}
resource "google_compute_subnetwork" "my-custom-public" {
  count                    = 2
  name                     = "${var.public-subnet-name}-${local.subnets2[count.index]}"
  ip_cidr_range            = var.public-subnet-cidir-range[count.index]
  region                   = var.public-subnet-region[count.index]
  private_ip_google_access = true
  secondary_ip_range {
    range_name    = var.secondary_range[count.index].range_name
    ip_cidr_range = var.secondary_range[count.index].ip_range
  }
  network    = google_compute_network.my-custom.id
  depends_on = [google_compute_network.my-custom]
}
resource "time_sleep" "wait_30_seconds1" {
  depends_on = [google_compute_subnetwork.my-custom-private]

  destroy_duration = "30s"
}
resource "time_sleep" "wait_30_seconds2" {
  depends_on = [google_compute_subnetwork.my-custom-public]

  destroy_duration = "30s"
}
############ Firewall configurations #########
resource "google_compute_firewall" "test-firewall-gcp" {
  name = var.firewall_name
  network = google_compute_network.my-custom.id
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports = ["80", "8080", "1000-2000"]
  }
  source_tags = ["web"]
}
############################### END OF VPC ############################
################################ Compute Engine ########################
resource "google_compute_instance" "project-test-instance" {
  count        = 2
  name         = var.instance_name[count.index]
  machine_type = var.machine-type
  network_interface {
    network    = google_compute_network.my-custom.id
    subnetwork =  "https://www.googleapis.com/compute/v1/projects/meta-buckeye-415304/regions/${var.instance-region[count.index]}/subnetworks/${var.private-subnet-name}-${local.subnets[count.index]}"
    access_config {
      network_tier = "PREMIUM"
    }
    stack_type = "IPV4_ONLY"
  }
  boot_disk {
    auto_delete = true
    initialize_params {
      image = var.instance-image
      size  = 20
      type  = "pd-balanced"
      labels = {
        my_label = "test-instance-disk"
      }
    }
    mode = "READ_WRITE"
  }
  service_account {
    email  = var.service-account
    scopes = ["cloud-platform"]
  }
  scheduling {
    preemptible                 = true
    automatic_restart           = false
    on_host_maintenance         = "TERMINATE"
    provisioning_model          = "SPOT"
    instance_termination_action = "DELETE"
  }
  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }
  allow_stopping_for_update = true
  can_ip_forward            = false
  deletion_protection       = false
  enable_display            = false
  zone                      = var.instance-zone[count.index]

}

########################################################################################################
################### Bucket creation ##############################################################
resource "google_storage_bucket" "test-bucket" {
  name = "test-bucket-with-terraform"
  location = var.provider-region
  force_destroy = true
  uniform_bucket_level_access = true
}
resource "google_storage_bucket_object" "picture" {
  name   = "butterfly01"
  source = "output.tf"
  bucket = google_storage_bucket.test-bucket.name
}

