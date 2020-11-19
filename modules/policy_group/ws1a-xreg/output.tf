output "groups" {
  value = {
    # provider = nsxt_policy_group.application_providers
    app = nsxt_policy_group.application
    lb = nsxt_policy_group.loadbalancer
    # intra-app = nsxt_policy_group.intra-app_providers

  }    
}