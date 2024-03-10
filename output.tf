
output "provider-region" {
  value = var.provider-region
}
output "allowed-ports" {
  value = "${google_compute_firewall.test-firewall-gcp.allow}"
}
output "name-of-instance" {
  value = "${google_compute_instance.project-test-instance[*].name}"
}
output "internal-ip" {
  value = "${google_compute_instance.project-test-instance[*].network_interface[0]["network_ip"]}"
}
output "external-ip" {
  value = "${google_compute_instance.project-test-instance[*].network_interface[0]["access_config"][0]["nat_ip"]}"
}
output "instance-id" {
  value = "${google_compute_instance.project-test-instance[*].instance_id}"
}
output "instance-zone" {
  value = "${google_compute_instance.project-test-instance[*].zone}"
}
#
output "storage-bucket-name" {
  value = google_storage_bucket.test-bucket.name
}
output "storage-bucket-location" {
  value = google_storage_bucket.test-bucket.location
}
output "storage-object-url" {
  value = google_storage_bucket_object.picture.media_link
}
