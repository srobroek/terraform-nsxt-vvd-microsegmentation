locals {
  services = [
      "HTTPS", 
      "SSH"
    ]

  }
  

##Define new services
resource "nsxt_policy_service" "ws1a-mgt" {
  description  = ""
  display_name = "ws1a mgt services"

  l4_port_set_entry {
    display_name      = "TCP8443"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["8443"]
  }
 
}

resource "nsxt_policy_service" "ws1a-https" {
  description  = ""
  display_name = "ws1a-reg https services"

  l4_port_set_entry {
    display_name      = "TCP7443"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["7443"]
  }
 
}

resource "nsxt_policy_service" "ws1a_cluster" {
  description  = ""
  display_name = "ws1a_cluster"

  l4_port_set_entry {
    display_name      = "UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["54328"]
  }
  l4_port_set_entry {
    display_name      = "TCP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["5701","8200","9300","9400","40002","40003"]
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

resource "nsxt_policy_security_policy" "wsa1-reg" {
  display_name = "${var.product}:"
  description  = "Workspace One access regional"
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
    display_name       = "${var.product}: https to appliances"

    source_groups      = [nsxt_policy_group.consumes-all-https.path]
    destination_groups = [nsxt_policy_group.provides-all-https.path]
    action             = "ALLOW"
    services         = [
      data.nsxt_policy_service.service["HTTPS"].path,
      nsxt_policy_service.ws1a-https.path,
      nsxt_policy_service.ws1a-mgt.path 

    ]

  }

    rule {
    display_name       = "${var.product}: https to loadbalancer"

    source_groups      = [nsxt_policy_group.consumes-lb-https.path]
    destination_groups = [nsxt_policy_group.provides-lb-https.path]
    action             = "ALLOW"
    services         = [
      data.nsxt_policy_service.service["HTTPS"].path,
      nsxt_policy_service.ws1a-https.path
    ]

  }


    rule {
    display_name       = "${var.product}: inter cluster communication"

    source_groups      = [nsxt_policy_group.consumes-all-icc.path]
    destination_groups = [nsxt_policy_group.provides-all-icc.path]
    action             = "ALLOW"
    services         = [nsxt_policy_service.ws1a_cluster.path]

  }

}
