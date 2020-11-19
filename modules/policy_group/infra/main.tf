## application groups


resource "nsxt_policy_group" "infra_groups" {
  display_name = "${each.key}.${var.product}.${var.environment}"
    criteria {
      ipaddress_expression {
        ip_addresses = each.value
      }
    }
    for_each = {for key, value in var.groups : key => value if length(value) != 0}
}
