variable "domain_name" {
description = "Domain name registered for Application"
}

variable "comment" {
description = "Comment added in hosted zone"      
}

variable "ttl" {
description = "TTL of Record"
}

variable "primaryhealthcheck" {
description = "Tag Name for Primary Instance Health Check"
}

variable "secondaryhealthcheck" {
description = "Tag Name for Secondary Instance Health Check"
}

variable "subdomain" {
description = "Sub Domain name to access Application"
}

variable "identifier1" {
}

variable "identifier2" {
}

variable "primaryip" {
}

variable "secondaryip" {
}
