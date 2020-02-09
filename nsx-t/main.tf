#
# The VMware NSX-T provider to connect to the NSX
# REST API running on the NSX-T Manager cluster.
#
provider "nsxt" {
  host                  = var.nsx_manager
  username              = var.nsx_username
  password              = var.nsx_password
  allow_unverified_ssl  = true
  max_retries           = 10
  retry_min_delay       = 500
  retry_max_delay       = 5000
  retry_on_status_codes = [429]
}

#
# The NSX-T Edge Cluster (for Tier-1 gateways)
#
data "nsxt_policy_edge_cluster" "edge_cluster-01" {
  display_name = "Tier-1 Cluster"
}

#
# The NSX-T Overlay Transport Zone
#
data "nsxt_policy_transport_zone" "overlay_tz" {
  display_name = "TZ-Overlay"
}

#
# The Tier-0 Gateway
#
data "nsxt_policy_tier0_gateway" "tier0_gateway" {
  display_name  = "T0"
}

#
# Create Tier-1 Gateway
#
resource "nsxt_policy_tier1_gateway" "tier1-01" {
  description     = "Managed by Terraform"
  display_name    = "T1-CustomerX"
  edge_cluster_path = data.nsxt_policy_edge_cluster.edge_cluster-01.path
  tier0_path      = "/infra/tier-0s/T0"
  enable_standby_relocation = "false"
  enable_firewall = false
  failover_mode   = "NON_PREEMPTIVE"
  route_advertisement_types = [
    "TIER1_LB_VIP",
    "TIER1_NAT",
    "TIER1_CONNECTED",
    "TIER1_STATIC_ROUTES"]
}

#
# Create segment web
#
resource "nsxt_policy_segment" "segment1" {
  description       = "Managed by Terraform"
  display_name      = "web"
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  connectivity_path = nsxt_policy_tier1_gateway.tier1-01.path
  subnet {
    cidr    = "172.16.1.1/24"
    }

  tag {
    scope = var.nsx_tag_scope
    tag   = var.nsx_tag
  }

  tag {
    scope = "tier"
    tag   = "web"
  }
}

#
# Create segment app
#
resource "nsxt_policy_segment" "segment2" {
  description       = "Managed by Terraform"
  display_name      = "web"
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  connectivity_path = nsxt_policy_tier1_gateway.tier1-01.path
  subnet {
    cidr    = "172.16.2.1/24"
    }

  tag {
    scope = var.nsx_tag_scope
    tag   = var.nsx_tag
  }

  tag {
    scope = "tier"
    tag   = "app"
  }
}

#
# Create segment db
#
resource "nsxt_policy_segment" "segment3" {
  description       = "Managed by Terraform"
  display_name      = "db"
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  connectivity_path = nsxt_policy_tier1_gateway.tier1-01.path
  subnet {
    cidr    = "172.16.3.1/24"
    }

  tag {
    scope = var.nsx_tag_scope
    tag   = var.nsx_tag
  }

  tag {
    scope = "tier"
    tag   = "db"
  }
}
