locals {
  services = [
      "DNS-UDP", 
      "NTP",
      "Syslog (TCP)",
      "Syslog (UDP)",
      "SMTP",
      "Microsoft Active Directory V1",
      "HTTPS",
      "SSH",
      "ICMP Echo Request",
      "ICMP Echo Reply"


    ]

  }
  




##Source existing services

data "nsxt_policy_service" "service" {

  for_each = toset(local.services)
  display_name = each.value
}



## create provider groups

resource "nsxt_policy_group" "provides-all-dns" {

  display_name = "provides.dns.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.provides_all_dns: value.path]
    }
  }
}

resource "nsxt_policy_group" "consumes-all-dns" {

  display_name = "consumes.dns.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_all_dns: value.path]
    }
  }
}

resource "nsxt_policy_group" "provides-all-ntp" {

  display_name = "provides.ntp.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.provides_all_ntp: value.path]
    }
  }
}

resource "nsxt_policy_group" "consumes-all-ntp" {

  display_name = "consumes.ntp.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_all_ntp: value.path]
    }
  }
}

# resource "nsxt_policy_group" "provides-all-proxy" {

#   display_name = "provides.proxy.all.${var.product}.${var.environment}"
#   criteria {
#     path_expression {
#       member_paths = [for key, value in var.groups.provides_all_proxy: value.path]
#     }
#   }
# }

# resource "nsxt_policy_group" "consumes-all-proxy" {

#   display_name = "consumes.proxy.all.${var.product}.${var.environment}"
#   criteria {
#     path_expression {
#       member_paths = [for key, value in var.groups.consumes_all_proxy: value.path]
#     }
#   }
# }

# resource "nsxt_policy_group" "provides-all-syslog" {

#   display_name = "provides.syslog.all.${var.product}.${var.environment}"
#   criteria {
#     path_expression {
#       member_paths = [for key, value in var.groups.provides_all_syslog: value.path]
#     }
#   }
# }

# resource "nsxt_policy_group" "consumes-all-syslog" {

#   display_name = "consumes.syslog.all.${var.product}.${var.environment}"
#   criteria {
#     path_expression {
#       member_paths = [for key, value in var.groups.consumes_all_syslog: value.path]
#     }
#   }
# }


resource "nsxt_policy_group" "emergency_allow" {

  display_name = "emergency allow"

}

resource "nsxt_policy_group" "emergency_deny" {

  display_name = "emergency deny"
}

resource "nsxt_policy_group" "provides-all-smtp" {

  display_name = "provides.smtp.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.provides_all_smtp: value.path]
    }
  }
}

resource "nsxt_policy_group" "consumes-all-smtp" {

  display_name = "consumes.smtp.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_all_smtp: value.path]
    }
  }
}


resource "nsxt_policy_group" "provides-all-ldap" {

  display_name = "provides.ldap.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.provides_all_ldap: value.path]
    }
  }
}

resource "nsxt_policy_group" "consumes-all-ldap" {

  display_name = "consumes.ldap.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_all_ldap: value.path]
    }
  }
}


resource "nsxt_policy_group" "provides-vcenter-https" {

  display_name = "provides.https.vcenter.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.provides_vcenter_https: value.path]
    }
  }
}

resource "nsxt_policy_group" "consumes-vcenter-https" {

  display_name = "consumes.https.vcenter.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_vcenter_https: value.path]
    }
  }
}

resource "nsxt_policy_group" "provides-esxi-https" {

  display_name = "provides.https.esxi.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.provides_esxi_https: value.path]
    }
  }
}

resource "nsxt_policy_group" "consumes-esxi-https" {

  display_name = "consumes.https.esxi.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_esxi_https: value.path]
    }
  }
}

resource "nsxt_policy_group" "provides-nsxmgr-https" {

  display_name = "provides.https.nsxmgr.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.provides_nsxmgr_https: value.path]
    }
  }
}

resource "nsxt_policy_group" "consumes-nsxmgr-https" {

  display_name = "consumes.https.nsxmgr.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_nsxmgr_https: value.path]
    }
  }
}

resource "nsxt_policy_group" "provides-nsxmgr-ssh" {

  display_name = "provides.ssh.nsxmgr.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.provides_nsxmgr_ssh: value.path]
    }
  }
}

resource "nsxt_policy_group" "consumes-nsxmgr-ssh" {

  display_name = "consumes.ssh.nsxmgr.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_nsxmgr_ssh: value.path]
    }
  }
}

resource "nsxt_policy_group" "provides-sddcmgr-https" {

  display_name = "provides.https.sddcmgr.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.provides_sddcmgr_https: value.path]
    }
  }
}

resource "nsxt_policy_group" "consumes-sddcmgr-https" {

  display_name = "consumes.https.sddcmgr.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_sddcmgr_https: value.path]
    }
  }
}

resource "nsxt_policy_group" "provides-sddcmgr-icmp" {

  display_name = "provides.icmp.sddcmgr.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_sddcmgr_icmp: value.path]
    }
  }
}


resource "nsxt_policy_group" "consumes-sddcmgr-icmp" {

  display_name = "consumes.icmp.sddcmgr.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_sddcmgr_icmp: value.path]
    }
  }
}



# ### firewall rules

resource "nsxt_policy_security_policy" "emergency" {
  display_name = "Emergency Rules"
  description  = ""
  category     = "Emergency"
  locked       = false
  stateful     = true
  tcp_strict   = false

  rule {
    display_name       = "Emergency allow"

    source_groups      = [nsxt_policy_group.emergency_allow.path]
    action             = "ALLOW"


  }

  rule {
    display_name       = "Emergency allow"
    destination_groups = [nsxt_policy_group.emergency_allow.path]
    action             = "ALLOW"


  }


  rule {
    display_name       = "Emergency Deny"

    source_groups      = [nsxt_policy_group.emergency_deny.path]
    action             = "ALLOW"


  }


  rule {
    display_name       = "Emergency Deny"

    destination_groups = [nsxt_policy_group.emergency_deny.path]
    action             = "ALLOW"


  }

}

resource "nsxt_policy_security_policy" "infra" {
  display_name = var.product
  description  = "Common infrastructure rules"
  category     = "Infrastructure"
  locked       = false
  stateful     = true
  tcp_strict   = false

  rule {
    display_name       = "${var.product}: DNS to DNS servers"

    source_groups      = [nsxt_policy_group.consumes-all-dns.path]
    destination_groups = [nsxt_policy_group.provides-all-dns.path]
    action             = "ALLOW"
    services         = [data.nsxt_policy_service.service["DNS-UDP"].path]

  }

  rule {
    display_name       = "${var.product}: NTP to NTP servers"

    source_groups      = [nsxt_policy_group.consumes-all-ntp.path]
    destination_groups = [nsxt_policy_group.provides-all-ntp.path]
    action             = "ALLOW"
    services         = [data.nsxt_policy_service.service["NTP"].path]

  }

  #  rule {
  #   display_name       = "Infrastucture: Proxy to Proxy servers"

  #   source_groups      = [nsxt_policy_group.consumes-all-proxy.path]
  #   destination_groups = [nsxt_policy_group.provides-all-proxy.path]
  #   action             = "ALLOW"
  #   services         = [nsxt_policy_service.proxy.path]

  # }

  # rule {
  #   display_name       = "Infrastucture: Syslog to Syslog servers"

  #   source_groups      = [nsxt_policy_group.consumes-all-syslog.path]
  #   destination_groups = [nsxt_policy_group.provides-all-syslog.path]
  #   action             = "ALLOW"
  #   services         = [
  #     data.nsxt_policy_service.service["Syslog (TCP)"].path,
  #     data.nsxt_policy_service.service["Syslog (UDP)"].path
  #   ]

  # }

  rule {
    display_name       = "${var.product}: SMTP to SMTP servers"

    source_groups      = [nsxt_policy_group.consumes-all-smtp.path]
    destination_groups = [nsxt_policy_group.provides-all-smtp.path]
    action             = "ALLOW"
    services         = [data.nsxt_policy_service.service["SMTP"].path]

  }


  rule {
    display_name       = "${var.product}: LDAP to LDAP servers"

    source_groups      = [nsxt_policy_group.consumes-all-ldap.path]
    destination_groups = [nsxt_policy_group.provides-all-ldap.path]
    action             = "ALLOW"
    services         = [data.nsxt_policy_service.service["Microsoft Active Directory V1"].path]

  }

}


resource "nsxt_policy_security_policy" "vcf" {
  display_name = "${var.product} - VCF"
  description  = "Common infrastructure - VCF"
  category     = "Infrastructure"
  locked       = false
  stateful     = true
  tcp_strict   = false

  rule {
    display_name       = "VCF: HTTPS to vCenter servers"

    source_groups      = [nsxt_policy_group.consumes-vcenter-https.path]
    destination_groups = [nsxt_policy_group.provides-vcenter-https.path]
    action             = "ALLOW"
    services         = [data.nsxt_policy_service.service["HTTPS"].path]

  }
  rule {
    display_name       = "VCF: HTTPS to ESXI servers"

    source_groups      = [nsxt_policy_group.consumes-esxi-https.path]
    destination_groups = [nsxt_policy_group.provides-esxi-https.path]
    action             = "ALLOW"
    services         = [data.nsxt_policy_service.service["HTTPS"].path]

  }

  rule {
    display_name       = "VCF: HTTPS to NSX Manager servers"

    source_groups      = [nsxt_policy_group.consumes-nsxmgr-https.path]
    destination_groups = [nsxt_policy_group.provides-nsxmgr-https.path]
    action             = "ALLOW"
    services         = [data.nsxt_policy_service.service["HTTPS"].path]

  }

  rule {
    display_name       = "VCF: SSH to NSX Manager servers"

    source_groups      = [nsxt_policy_group.consumes-nsxmgr-ssh.path]
    destination_groups = [nsxt_policy_group.provides-nsxmgr-ssh.path]
    action             = "ALLOW"
    services         = [data.nsxt_policy_service.service["SSH"].path]

  }

  rule {
    display_name       = "VCF: HTTPS to SDDC Manager servers"

    source_groups      = [nsxt_policy_group.consumes-sddcmgr-https.path]
    destination_groups = [nsxt_policy_group.provides-sddcmgr-https.path]
    action             = "ALLOW"
    services         = [data.nsxt_policy_service.service["HTTPS"].path]

  }

  rule {
    display_name       = "VCF: ICMP from SDDC Manager servers"

    source_groups      = [nsxt_policy_group.consumes-sddcmgr-icmp.path]
    destination_groups = [nsxt_policy_group.provides-sddcmgr-icmp.path]
    action             = "ALLOW"
    services         = [
      data.nsxt_policy_service.service["ICMP Echo Request"].path,
      data.nsxt_policy_service.service["ICMP Echo Reply"].path,
      ]

  }


}    