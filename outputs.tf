output "name" { value = local.name }
output "state" { value = local.enabled ? one(google_compute_network_peering.default).state : null }
output "state_details" { value = local.enabled ? one(google_compute_network_peering.default).state_details : null }
