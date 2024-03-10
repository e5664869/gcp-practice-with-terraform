gcp-project                = "meta-buckeye-415304"
provider-region            = "us-central1"
vpc-name                   = "my-custom-vpc"
private-subnet-name        = "my-custom-subnet"
private-subnet-region      = ["us-central1", "us-east1"]
private-subnet-cidir-range = ["10.10.10.0/24", "15.15.100.0/28"]

public-subnet-name        = "my-custom-subnet"
public-subnet-region      = ["us-west1", "us-east1"]
public-subnet-cidir-range = ["101.10.10.0/24", "151.15.100.0/28"]
secondary_range = [{
  ip_range   = "192.168.10.0/24"
  range_name = "secondary-range-subnet1"
  },
  {
    ip_range   = "172.50.10.0/28"
    range_name = "secondary-range-subnet2"
  }
]
###############Firewall ############
firewall_name = "test-with-terraform"
#################################################
instance_name   = ["test-instance1", "test-instance2"]
machine-type    = "e2-micro"
service-account = "terraform-gcp-svc@meta-buckeye-415304.iam.gserviceaccount.com"
instance-zone   = ["us-central1-c", "us-east1-c"]
instance-image  = "projects/centos-cloud/global/images/centos-7-v20240213"
instance-region = [ "us-central1", "us-east1" ]