nsxt_edgecluster = "edgecluster"
nsxt_host = "nsxmanager01.lab.local"
nsxt_username = "admin"
nsxt_password = "VMware1!VMware1!"
nsxt_logical_tier0_router = "t0"
nsxt_overlay_tz = "tz-overlay"

# K8s-specific

k8s_api_lb_ip = "10.80.80.10" # Leave this as-is, will be the IP address for our node.
vsphere_user = "administrator@vsphere.local"
vsphere_password = "VMware1!"
vsphere_server = "vcenter.lab.local"
nsx_container_ipblocks = "10.101.0.0/16"
external_ip_pools_lb = "10.10.201.0/24"
clustername = "terraform_cluster_1"
ovs_uplink_port = "ens192"
apiserver_host_port = "6443"
ncp_image_location = "harbor.mydomain.co.uk/library/nsx-ncp-ubuntu:latest"


# Rancher-specific

rancher2_access_key = "sometoken"
rancher2_secret_key = "somekey"
rancher2_baseurl = "https://rancher.mydomain.co.uk"
rancher2_clusterid = "mycluster"

# Node-specific

template_name = "templatename"
template_num_cpu = "2"
template_disk_size = "20000"
node_datastore = "NFS-500"
node_datacenter = "Homelab"
node_resourcepool = "RP-1"
node_mem_size = "4092"