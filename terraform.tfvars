
vra = {
  environment = "mgt"      
  product = "vra"

  groups = {
    lb_groups: ["NLB.VIP.[vc]", "NLB.VIP.[a]"]
    application_vms: ["esxi01.lab01.lab.vxsan.com", "esxi02.lab02.lab.vxsan.com"]
  }
}

ws1a-reg = {
  environment: "mgt"      
  product: "ws1a-reg"

  groups = {
    lb_groups: ["NLB.VIP.[vc]", "NLB.VIP.[a]"]
    application_vms: ["esxi01.lab01.lab.vxsan.com", "esxi02.lab02.lab.vxsan.com"]
  }
}

ws1a-xreg = {
  environment: "mgt"      
  product: "ws1a-xreg"

  groups = {
    lb_groups: ["NLB.VIP.[vc]", "NLB.VIP.[a]"]
    application_vms: ["esxi01.lab01.lab.vxsan.com", "esxi02.lab02.lab.vxsan.com"]
  }
}

vrli = {
  environment: "mgt"      
  product: "vrli"

  groups = {
    lb_addresses: ["1.2.3.4","2.3.4.5"]
    application_vms: ["esxi01.lab01.lab.vxsan.com", "esxi02.lab02.lab.vxsan.com"]
  }
}

vrlcm = {
  environment: "mgt"      
  product: "vrlcm"

  groups = {
    application_vms: ["esxi01.lab01.lab.vxsan.com"]
  }
}

# variable "vrlcm" {
#   type = object({
#       product_name = string 
#       enabled = bool
#       vms = map(string)
#     })

# }


# vrops = {
#   environment = "mgt"      
#   product_name = "vrops"
#   enabled = true
#   master_vms = ["esxi01.lab01.lab.vxsan.com", "esxi02.lab02.lab.vxsan.com"]
#   analytics_vms = ["esxi01.lab01.lab.vxsan.com", "esxi02.lab02.lab.vxsan.com"]
#   data_vms = ["esxi01.lab01.lab.vxsan.com", "esxi02.lab02.lab.vxsan.com"]
#   collector_vms = ["esxi01.lab01.lab.vxsan.com", "esxi02.lab02.lab.vxsan.com"]
#   ##this must include both your NLB VIP as well as your NLB PoolIP, if these are different. 
#   lb_groups = ["NLB.VIP.[vc]", "NLB.VIP.[a]"]
# }

infra = {
  product: "infra"
  environment: "prod"
  groups = {
  dns: [
    "1.2.3.4",
    "2.3.4.5"
  ]
  ntp: [
    "1.2.3.4",
    "2.3.4.5"
  ]
    smtp: [
    "1.2.3.4",
    "2.3.4.5"
  ]
  ldap: [
    "1.2.3.4",
    "2.3.4.5"
  ]

  vcenter: [
    "1.2.3.4"
  ]
  esxi: [
    "1.2.3.4"
  ]
  nsxmgr: [
    "1.2.3.4"
  ]
  sddcmgr: [
    "1.2.3.4"
  ]

  admin_net: [
    "10.0.0.0/16"
  ]
  user_net: [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  }
  sddc_segments: [
    "VLAB01-VTEP",
    "VLAB02-VTEP"
  ]  
}



# variable "vrni" {
#   type = object({
#       product_name = string 
#       enabled = bool
#       platform_vms = map(string)
#       collector_vms = map(string)
#     })

# }

# variable "vrli" {
#   type = object({
#       product_name = string 
#       enabled = bool
#       vms = map(string)
#       lb_vips = map(string)
#       flannel_subnet = string
#     })

# }




# variable "vcf" {
#   type = object({
#       product_name = string 
#       enabled = bool
#       vcenter_ip = map(string)
#       nsxmgr_ip = map(string)
#       sddcmgr_ip = map(string)
#       esxi_ip = map(string)

#     })

# }

