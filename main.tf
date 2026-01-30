



data "terraform_remote_state" "remote_outputs" {
  backend = "remote"

  config = {
    organization = "Equinix-ReferenceArchitecture"
    workspaces = {
      name = "Deploy-DualNE-DualMetro-Parent"
    }
  }
}

resource "random_pet" "this" {
  length = 2
}

## to create VC's from NE's to AWS 

resource "equinix_fabric_connection" "vd2AWS_Pri" {
  name = "Pri-${random_pet.this.id}"
  type = "EVPL_VC"
  notifications {
    type   = "ALL"
    emails = var.notifications
  }
  bandwidth = var.bandwidth_1
  order {
    purchase_order_number = var.purchase_order
  }
  a_side {
    access_point {
      type = "VD"
      virtual_device {
        type = "EDGE"
        uuid = data.terraform_remote_state.remote_outputs.outputs.primary_device_uuid
      }
      interface {
        type = "CLOUD"
        id = var.Interface_AWS_VC_1
      }
    }
  }
  z_side {
    access_point {
      type               = "SP"
      authentication_key = var.authentication_key
      seller_region      = var.seller_region
      profile {
        type = "L2_PROFILE"
        uuid = var.profile_uuid
      }
      location {
        metro_code = var.Pri_AWS_Region
      }
    }
  }
}

resource "equinix_fabric_connection" "vd2AWS_Sec" {
  name = "Sec-${random_pet.this.id}"
  type = "EVPL_VC"
  notifications {
    type   = "ALL"
    emails = var.notifications
  }
  bandwidth = var.bandwidth_2
  order {
    purchase_order_number = var.purchase_order
  }
  a_side {
    access_point {
      type = "VD"
      virtual_device {
        type = "EDGE"
        uuid = data.terraform_remote_state.remote_outputs.outputs.secondary_device_uuid
      }
      interface {
        type = "CLOUD"
        id = var.Interface_AWS_VC_2
      }
    }
  }
  z_side {
    access_point {
      type               = "SP"
      authentication_key = var.authentication_key
      seller_region      = var.seller_region_sec
      profile {
        type = "L2_PROFILE"
        uuid = var.profile_uuid
      }
      location {
        metro_code = var.Sec_AWS_Region
      }
    }
  }
}

## data source to fetch AWS Dx connection ID - first primary connection

data "aws_dx_connection" "aws_connection" {
  depends_on = [
    equinix_fabric_connection.vd2AWS_Pri
  ]
  name = "Pri-${random_pet.this.id}"
}

## to accept AWS Dx Connection - first primary connection 

resource "aws_dx_connection_confirmation" "localname1" {
depends_on = [
    equinix_fabric_connection.vd2AWS_Pri
  ]
  connection_id = data.aws_dx_connection.aws_connection.id
}

## data source to fetch AWS Dx connection ID - for secondary connection

data "aws_dx_connection" "aws_connection_2" {
  depends_on = [
    equinix_fabric_connection.vd2AWS_Sec
  ]
  name = "Sec-${random_pet.this.id}"
  provider = aws.ap-east-1
}

## to accept AWS Dx Connection - for secondary  connection 

resource "aws_dx_connection_confirmation" "localname2" {
depends_on = [
    equinix_fabric_connection.vd2AWS_Sec
  ]
  connection_id = data.aws_dx_connection.aws_connection_2.id
  provider = aws.ap-east-1
}



