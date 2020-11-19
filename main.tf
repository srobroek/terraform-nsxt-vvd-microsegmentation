module "groups_vra" {
  source = "./modules/policy_group/vra"
  product = var.vra.product
  environment = var.vra.environment
  groups = var.vra.groups
}

module "groups_infra" {
  source = "./modules/policy_group/infra"

  product = var.infra.product
  environment = var.infra.environment
  groups = var.infra.groups
}

module "groups_ws1a-reg" {
  source = "./modules/policy_group/ws1a-reg"
  product = var.ws1a-reg.product
  environment = var.ws1a-reg.environment
  groups = var.ws1a-reg.groups
}

module "groups_ws1a-xreg" {
  source = "./modules/policy_group/ws1a-xreg"
  product = var.ws1a-xreg.product
  environment = var.ws1a-xreg.environment
  groups = var.ws1a-xreg.groups
}

module "groups_vrlcm" {
  source = "./modules/policy_group/vrlcm"
  product = var.vrlcm.product
  environment = var.vrlcm.environment
  groups = var.vrlcm.groups
}

module "groups_vrli" {
  source = "./modules/policy_group/vrli"
  product = var.vrli.product
  environment = var.vrli.environment
  groups = var.vrli.groups
}

# module "groups_ws1a-xreg" {
#   source = "./modules/policy_group/ws1a-xreg"
#   product = var.ws1a-xreg.product
#   environment = var.ws1a-xreg.environment
#   groups = var.ws1a-xreg.groups
# }

# module "groups_vrops" {
#   source = "./modules/policy_group/vrops"
#   product = var.vrops.product
#   environment = var.vrops.environment
#   groups = var.vrops.groups
# }

# module "groups_vrli" {
#   source = "./modules/policy_group/vrli"
#   product = var.vrli.product
#   environment = var.vrli.environment
#   groups = var.vrli.groups
# }

# module "groups_vrlcm" {
#   source = "./modules/policy_group/vrlcm"
#   product = var.vrlcm.product
#   environment = var.vrlcm.environment
#   groups = var.vrlcm.groups
# }


#sddc_segments = var.infra.sddc_segments

module "dfw_vra" {
  source  = "./modules/policy_security_policy/vra"
#  groups = module.groups_vra.groups
  groups = {
    provides_all_https = [
      module.groups_vra.groups["app"]
    ]
    provides_all_ssh   = [
      module.groups_vra.groups["app"]
    ]
    provides_lb_https  = [
      module.groups_vra.groups["lb"]
    ]
    provides_all_icc   = [
      module.groups_vra.groups["app"], 
      module.groups_vra.groups["calico"]
    ]
    consumes_all_https = [
      module.groups_vra.groups["lb"],
      module.groups_vra.groups["app"],
      module.groups_infra.groups["admin_net"]
    ]
    consumes_all_ssh   = [
      module.groups_vra.groups["app"], 
      module.groups_infra.groups["admin_net"]
    ]
    consumes_lb_https  = [
      module.groups_vra.groups["app"], 
      module.groups_vra.groups.calico, 
      module.groups_infra.groups["user_net"], 
      module.groups_infra.groups["admin_net"]
    ]
    consumes_all_icc   = [
      module.groups_vra.groups["app"], 
      module.groups_vra.groups["calico"]
      ]
    


  }
  product = var.vra.product
  environment = var.vra.environment
}

module "dfw_wsa1-reg" {
  source  = "./modules/policy_security_policy/ws1a-reg"
  groups = {
    provides_all_https = [
      module.groups_ws1a-reg.groups["app"]
    ]
    provides_all_ssh   = [
      module.groups_ws1a-reg.groups["app"]
    ]
    provides_lb_https  = [
      module.groups_ws1a-reg.groups["lb"]
    ]
    provides_all_icc   = [
      module.groups_ws1a-reg.groups["app"], 
    ]
    consumes_all_https = [
      module.groups_ws1a-reg.groups["lb"],
      module.groups_infra.groups["admin_net"]
    ]
    consumes_all_ssh   = [
      module.groups_infra.groups["admin_net"]
    ]
    consumes_lb_https  = [
      module.groups_ws1a-reg.groups["app"], 
      module.groups_infra.groups["user_net"], 
      module.groups_infra.groups["admin_net"]
    ]
    consumes_all_icc   = [
      module.groups_ws1a-reg.groups["app"], 
      ]
    


  }
  product = var.ws1a-reg.product
  environment = var.ws1a-reg.environment
}

module "dfw_wsa1-xreg" {
  source  = "./modules/policy_security_policy/ws1a-xreg"
  groups = {
    provides_all_https = [
      module.groups_ws1a-xreg.groups["app"]
    ]
    provides_all_ssh   = [
      module.groups_ws1a-xreg.groups["app"]
    ]
    provides_lb_https  = [
      module.groups_ws1a-xreg.groups["lb"]
    ]
    provides_all_icc   = [
      module.groups_ws1a-xreg.groups["app"], 
    ]
    consumes_all_https = [
      module.groups_ws1a-xreg.groups["lb"],
      module.groups_infra.groups["admin_net"]
    ]
    consumes_all_ssh   = [
      module.groups_infra.groups["admin_net"]
    ]
    consumes_lb_https  = [
      module.groups_ws1a-xreg.groups["app"], 
      module.groups_infra.groups["user_net"], 
      module.groups_infra.groups["admin_net"]
    ]
    consumes_all_icc   = [
      module.groups_ws1a-xreg.groups["app"], 
      ]
    


  }
  product = var.ws1a-xreg.product
  environment = var.ws1a-xreg.environment
}

module "vrli" {
  source  = "./modules/policy_security_policy/vrli"
  groups = {
    provides_all_https = [
      module.groups_vrli.groups["app"]
    ]
    provides_all_ssh = [
      module.groups_vrli.groups["app"]
    ]
    provides_lb_https  = [
      module.groups_vrli.groups["lb"]
      
    ]
    provides_all_syslog   = [
      module.groups_vrli.groups["app"], 
       module.groups_vrli.groups["lb"]
    ]    
    provides_all_cfapi   = [
      module.groups_vrli.groups["app"], 
       module.groups_vrli.groups["lb"]
    ]    
    provides_all_icc   = [
      module.groups_vrli.groups["app"], 
      module.groups_vrli.groups["lb"]  
    ]
    consumes_all_https = [
      module.groups_vrli.groups["lb"],
      module.groups_infra.groups["admin_net"]
    ]
    consumes_all_ssh   = [
      module.groups_infra.groups["admin_net"]
    ]
    consumes_all_syslog   = [
      module.groups_infra.groups["admin_net"]
    ]    
    consumes_all_cfapi   = [
      module.groups_infra.groups["admin_net"]
    ]    
    consumes_lb_https  = [
      module.groups_vrli.groups["app"], 
      module.groups_infra.groups["user_net"], 
      module.groups_infra.groups["admin_net"]
    ]
    consumes_all_icc   = [
      module.groups_vrli.groups["app"], 
      ]
    


  }
  product = var.vrli.product
  environment = var.vrli.environment
}


module "dfw_vrlcm" {
  source  = "./modules/policy_security_policy/vrlcm"
  groups = {
    provides_all_https = [
      module.groups_vrlcm.groups["app"]
    ]
    provides_all_ssh   = [
      module.groups_vrlcm.groups["app"]
    ]
    consumes_all_https = [
      module.groups_infra.groups["admin_net"]
    ]
    consumes_all_ssh   = [
      module.groups_infra.groups["admin_net"]
    ]

    


  }
  product = var.vrlcm.product
  environment = var.vrlcm.environment
}

module "dfw_infra" {
  source  = "./modules/policy_security_policy/infra"
#  groups = module.groups_vra.groups
  groups = {
    provides_all_dns = [
      module.groups_infra.groups["dns"]
    ]

    provides_all_ntp = [
      module.groups_infra.groups["ntp"]
    ]


    provides_all_smtp = [
      module.groups_infra.groups["smtp"]

    ]

    provides_all_ldap = [
      module.groups_infra.groups["ldap"]      

    ]

    provides_vcenter_https = [
      module.groups_infra.groups["vcenter"]      

    ]

    provides_esxi_https = [
      module.groups_infra.groups["esxi"]      

    ]
   

    provides_nsxmgr_https = [
      module.groups_infra.groups["nsxmgr"]      

    ]


    provides_nsxmgr_ssh = [
      module.groups_infra.groups["nsxmgr"]      

    ]

    provides_sddcmgr_https = [
      module.groups_infra.groups["sddcmgr"]      

    ]

   provides_sddcmgr_icmp = [
      module.groups_vra.groups["app"]

    ]
    consumes_sddcmgr_icmp = [
          module.groups_infra.groups["sddcmgr"]

    ] 
    consumes_all_dns = [
      module.groups_vra.groups["app"]
    ]  
    consumes_sddcmgr_https = [
          module.groups_vra.groups["app"]

    ] 
    consumes_nsxmgr_ssh = [
          module.groups_vra.groups["app"]

    ] 
    consumes_nsxmgr_https = [
          module.groups_vra.groups["app"]
    ] 
    consumes_esxi_https = [
          module.groups_vra.groups["app"]

    ] 
    consumes_vcenter_https = [
          module.groups_vra.groups["app"]

    ]   
    consumes_all_ldap = [
       module.groups_vra.groups["app"]
    ]     
    consumes_all_smtp = [
      module.groups_vra.groups["app"]
    ]    
    consumes_all_ntp = [
      module.groups_vra.groups["app"]
    ]    

  }
  product = var.infra.product
  environment = var.infra.environment
}






