variable "vra" {
  type = object({
      environment = string      
      product = string 
      groups = map(list(string))
    })

}

variable "ws1a-reg" {
  type = object({
      environment = string      
      product = string 
      groups = map(list(string))
    })

}

variable "ws1a-xreg" {
  type = object({
      environment = string      
      product = string 
      groups = map(list(string))
    })

}

variable "infra" {
  type = object({
      groups = map(list(string))
      environment = string
      product = string 



    })
}

variable "vrlcm" {
  type = object({
      groups = map(list(string))
      environment = string
      product = string 



    })
}

variable "vrli" {
  type = object({
      groups = map(list(string))
      environment = string
      product = string 



    })
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

# variable "vrlcm" {
#   type = object({
#       product_name = string 
#       enabled = bool
#       vms = map(string)
#     })

# }

# variable "ws1a-reg" {
#   type = object({
#       product_name = string 
#       enabled = bool
#       vms = map(string)
#       lb_groups = map(string)      
#     })

# }


# variable "ws1a-xreg" {
#   type = object({
#       product_name = string 
#       enabled = bool
#       vms = map(string)
#       lb_groups = map(string)
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