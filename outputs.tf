
output "Dx_connection_Name_Pri" {
  value = data.aws_dx_connection.aws_connection.name
}

output "Dx_connection_Name_Sec" {
  value = data.aws_dx_connection.aws_connection_2.name
}

output "Dx_connection_ID_Pri" {
  value = data.aws_dx_connection.aws_connection.id
}

output "Dx_connection_ID_Sec" {
  value = data.aws_dx_connection.aws_connection_2.id
}

output "Dx_VLAN_ID_Pri" {
  value = data.aws_dx_connection.aws_connection.vlan_id
}

output "Dx_VLAN_ID_Sec" {
  value = data.aws_dx_connection.aws_connection_2.vlan_id
}

output "Equinix_VC_ID_Pri" {
  value = equinix_fabric_connection.vd2AWS_Pri.uuid
}

output "Equinix_VC_ID_Sec" {
  value = equinix_fabric_connection.vd2AWS_Sec.uuid
}

