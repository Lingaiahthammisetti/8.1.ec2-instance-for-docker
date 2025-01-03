variable "allow_everything" {
   type = string
   default = "sg-06b1b57b365846051"
}
# variable "zone_id" {
#     default = "Z05940111WEZ41S324XIY"
# }
# variable "domain_name" {
#   default = "lingaiah.online"
# }

variable "ec2_instance" {
   default = {
        instance_type  = "t3.medium"
   }
}
