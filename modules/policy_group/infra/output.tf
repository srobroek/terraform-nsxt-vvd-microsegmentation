output "groups" {
  value = {
    for key, value in nsxt_policy_group.infra_groups:
      key => value 
    #groups = [nsxt_policy_group.infra_groups.*]
    # provider_groups = nsxt_policy_group.application_providers
    # application_groups = nsxt_policy_group.application
    # loadbalancer_groups = nsxt_policy_group.loadbalancer

  }    
}