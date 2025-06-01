variable "equinix_client_id" {
  description = "Equinix client ID (consumer key), obtained after registering app in the developer platform"
  type        = string
}
variable "equinix_client_secret" {
  description = "Equinix client secret ID (consumer secret), obtained after registering app in the developer platform"
  type        = string
}

variable "notifications" {
  description = "Email addresses" 
  type        = list(string)
}

variable "authentication_key" {
  description = "AWS ID"
  type        = string
}
variable "seller_region" {
  description = "Seller Region"
  type        = string
}

variable "seller_region_sec" {
  description = "Seller Region"
  type        = string
}

variable "profile_uuid" {
  description = "AWS profile UUID"
  type        = string
}

variable "aws_access_key" {
  type    = string
  default = ""
}

variable "aws_secret_key" {
  type    = string
  default = ""
}

variable "aws_zside_seller_region" {
  description = "Access point seller region"
  type        = string
  default     = ""
}


variable "bandwidth_1" {
  description = "bandwidth for the First AWS Connection"
  type        = number
}

variable "bandwidth_2" {
  description = "bandwidth for the Second AWS Connection"
  type        = number
}

variable "purchase_order" {
  description = "PO for Equinix"
  type        = string
}

variable "Interface_AWS_VC_1" {
  description = "Interface no: of AWS VC in NE1"
  type        = number
}

variable "Interface_AWS_VC_2" {
  description = "Interface no: of AWS VC in NE2"
  type        = number
}

variable "Pri_AWS_Region" {
  description = "Primary AWS Region"
  type        = string
}

variable "Sec_AWS_Region" {
  description = "Secondary AWS Region"
  type        = string
}
