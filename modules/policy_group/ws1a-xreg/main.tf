locals {
  tags = {
    application:     [
      "environment|${var.environment}",
      "application|${var.product}",
    ]
  } 
}


### get preexisting groups

data "nsxt_policy_group" "lb_groups" {
  for_each = {
    for key, value in var.groups.lb_groups: key => value
  }
  display_name = each.value
}

### get tag VMs
data "nsxt_policy_vm" "vms" {
   display_name = each.value
   for_each = toset(var.groups.application_vms)
}



### create tags
resource "nsxt_policy_vm_tags" "application_tags" {
  depends_on = [
    data.nsxt_policy_vm.vms 
  ]
  
  instance_id = (data.nsxt_policy_vm.vms[each.key]).instance_id

  dynamic "tag" {
    for_each = local.tags.application

    content {
      scope = split("|", tag.value)[0]
      tag = split("|", tag.value)[1]
    }
  }
  for_each = toset(var.groups.application_vms)
}


## application groups


resource "nsxt_policy_group" "application" {

  display_name = "all.${var.product}.${var.environment}"
  criteria {
    dynamic "condition" {
      for_each = local.tags.application
      content {
        key = "Tag"
        member_type = "VirtualMachine"
        operator = "EQUALS"
        value = condition.value
      }
    }
  }
}




resource "nsxt_policy_group" "loadbalancer" {

  display_name = "lb.${var.product}.${var.environment}"
  criteria {
    path_expression {
      member_paths = [for key, value in var.groups.lb_groups: (data.nsxt_policy_group.lb_groups[key]).path]
    }
  }
}


