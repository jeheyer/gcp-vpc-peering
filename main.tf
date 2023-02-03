locals {
  enabled          = var.enabled == false ? false : true
  our_network_name = coalesce(var.our_network_name, "default")
  our_network_uri  = "projects/${var.project_id}/global/networks/${local.our_network_name}"
  peer_project_id  = coalesce(var.peer_project_id, var.project_id)
  peer_network_uri = "projects/${local.peer_project_id}/global/networks/${var.peer_network_name}"
  name             = coalesce(var.name, "${local.our_network_name}-${var.peer_network_name}")
}

resource "google_compute_network_peering" "default" {
  count                               = local.enabled ? 1 : 0
  name                                = local.name
  network                             = local.our_network_uri
  peer_network                        = local.peer_network_uri
  import_custom_routes                = coalesce(var.import_custom_routes, false)
  export_custom_routes                = coalesce(var.export_custom_routes, false)
  import_subnet_routes_with_public_ip = coalesce(var.import_subnet_routes_with_public_ip, false)
  export_subnet_routes_with_public_ip = coalesce(var.export_subnet_routes_with_public_ip, true)
}

