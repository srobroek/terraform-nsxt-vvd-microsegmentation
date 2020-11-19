locals {
  services = [
      "HTTPS", 
      "SSH",
      "Syslog (UDP)",
      "Syslog (TCP)"
    ]

  }
  


##Define new services
resource "nsxt_policy_service" "vrlcm_config" {
  description  = ""
  display_name = "vrlcm_config"

  l4_port_set_entry {
    display_name      = "TCP16420"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["16520"]
  }
}


##Define new services
resource "nsxt_policy_service" "CFAPI" {
  description  = ""
  display_name = "CFAPI"

  l4_port_set_entry {
    display_name      = "TCP9000"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["9000"]
  }
}

resource "nsxt_policy_service" "CFAPI-SSL" {
  description  = ""
  display_name = "CFAPI"

  l4_port_set_entry {
    display_name      = "TCP9543"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["9543"]
  }
}

resource "nsxt_policy_service" "vrli_cluster" {
  description  = ""
  display_name = "vra_cluster"


  l4_port_set_entry {
    display_name      = "TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["7000-7001","9042","16520-16580","59778"]
  }
}



##Source existing services

data "nsxt_policy_service" "service" {

  for_each = toset(local.services)
  display_name = each.value
}



## create provider groups

resource "nsxt_policy_group" "provides-all-ssh" {

  display_name = "provides.ssh.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_all_ssh: value.path]
    }
  }
}

resource "nsxt_policy_group" "consumes-all-ssh" {

  display_name = "consumes.ssh.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [ for key, value in var.groups.consumes_all_ssh: value.path ]
    }
  }
}

resource "nsxt_policy_group" "provides-all-https" {

  display_name = "provides.https.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [ for key, value in var.groups.provides_all_https: value.path ]
    }
  }
}

resource "nsxt_policy_group" "consumes-all-https" {

  display_name = "consumes.https.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_all_https: value.path]
    }
  }
}

resource "nsxt_policy_group" "provides-all-syslog" {

  display_name = "provides.syslog.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [ for key, value in var.groups.provides_all_syslog: value.path ]
    }
  }
}

resource "nsxt_policy_group" "consumes-all-syslog" {

  display_name = "consumes.syslog.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_all_syslog: value.path]
    }
  }
}

resource "nsxt_policy_group" "provides-all-cfapi" {

  display_name = "provides.cfapi.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [ for key, value in var.groups.provides_all_cfapi: value.path ]
    }
  }
}

resource "nsxt_policy_group" "consumes-all-cfapi" {

  display_name = "consumes.cfapi.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_all_cfapi: value.path]
    }
  }
}

resource "nsxt_policy_group" "provides-lb-https" {

  display_name = "provides.https.lb.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.provides_lb_https: value.path ]
    }
  }
}

resource "nsxt_policy_group" "consumes-lb-https" {

  display_name = "consumes.https.lb.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_lb_https: value.path]
    }
  }
}

resource "nsxt_policy_group" "provides-all-icc" {

  display_name = "provides.icc.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.provides_all_icc: value.path ]
    }
  }
}

resource "nsxt_policy_group" "consumes-all-icc" {

  display_name = "consumes.icc.all.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.consumes_all_icc: value.path ]
    }
  }
}









### firewall rules

resource "nsxt_policy_security_policy" "vrli" {
  display_name = "${var.product}"
  description  = "vRealize Log insight"
  category     = "Application"
  locked       = false
  stateful     = true
  tcp_strict   = false

  rule {
    display_name       = "${var.product}: ssh to appliances"

    source_groups      = [nsxt_policy_group.consumes-all-ssh.path]
    destination_groups = [nsxt_policy_group.provides-all-ssh.path]
    action             = "ALLOW"
    services         = [data.nsxt_policy_service.service["SSH"].path]

  }

  rule {
    display_name       = "${var.product}:https to appliances"

    source_groups      = [nsxt_policy_group.consumes-all-https.path]
    destination_groups = [nsxt_policy_group.provides-all-https.path]
    action             = "ALLOW"
    services         = [
      data.nsxt_policy_service.service["HTTPS"].path,

    ]

  }

    rule {
    display_name       = "${var.product}: https to loadbalancer"

    source_groups      = [nsxt_policy_group.consumes-lb-https.path]
    destination_groups = [nsxt_policy_group.provides-lb-https.path]
    action             = "ALLOW"
    services         = [
      data.nsxt_policy_service.service["HTTPS"].path,
    ]

  }

    rule {
    display_name       = "${var.product}: syslog to loadbalancer"

    source_groups      = [nsxt_policy_group.consumes-all-syslog.path]
    destination_groups = [nsxt_policy_group.provides-all-syslog.path]
    action             = "ALLOW"
    services         = [
      data.nsxt_policy_service.service["Syslog (UDP)"].path,
      data.nsxt_policy_service.service["Syslog (TCP)"].path
    ]

  }

  
    rule {
    display_name       = "${var.product}: CFAPI to loadbalancer"

    source_groups      = [nsxt_policy_group.consumes-all-cfapi.path]
    destination_groups = [nsxt_policy_group.provides-all-cfapi.path]
    action             = "ALLOW"
    services         = [
      nsxt_policy_service.CFAPI.path,
      nsxt_policy_service.CFAPI-SSL.path
    ]

  }


    rule {
    display_name       = "${var.product}: inter cluster communication"

    source_groups      = [nsxt_policy_group.consumes-all-icc.path]
    destination_groups = [nsxt_policy_group.provides-all-icc.path]
    action             = "ALLOW"
    services         = [nsxt_policy_service.vrli_cluster.path]

  }

}
