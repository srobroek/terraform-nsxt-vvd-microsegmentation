locals {
  tags = {
    application:     [
      "environment|${var.environment}",
      "application|${var.product}",
    ]
  } 
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




