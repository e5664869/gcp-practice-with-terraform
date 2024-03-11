gcp-project            = "meta-buckeye-415304"
provider-region        = "us-central1"
mig_vpc_name           = "mig-vpc-test"
mig_subnet_name        = "mig-subnet"
mig_subnet_region      = ["us-west1", "us-east1"]
mig_subnet_cidir_range = ["101.10.10.0/28", "151.15.100.0/28"]
firewall_name = "mig-firewall"
firewall_name2 = "mig-health-check"
template_name = "uat-template"
template_region = "us-east1"
template_machine_type = "e2-micro"
template_label = "uat-version1"
template_metadata ={
"startup-script" = "#! /bin/bash \nENV=$(curl -H \"Metadata-Flavor: Google\" http://metadata.google.internal/computeMetadata/v1/instance/attributes/env)\nNAME=$(curl -H \"Metadata-Flavor: Google\" http://metadata.google.internal/computeMetadata/v1/instance/name)\nZONE=$(curl -H \"Metadata-Flavor: Google\" http://metadata.google.internal/computeMetadata/v1/instance/zone | sed 's@.*/@@')\nPROJECT=$(curl -H \"Metadata-Flavor: Google\" http://metadata.google.internal/computeMetadata/v1/project/project-id)\nsudo yum install -y httpd\nsudo systemctl start httpd\nsudo chmod 777 /var/www/html\nsudo cat <<EOF> /var/www/html/index.html\n<body style=\"font-family: sans-serif\">\n<html><body><h1>Aaaand.... Success!</h1>\n<p>My machine name is <span style=\"color: #3BA959\">$NAME</span> and I serve the <span style=\"color: #3BA959\">$ENV</span> environment.</p>\n<p>I live comfortably in the <span style=\"color: #5383EC\">$ZONE</span> datacenter and proudly serve Tony Bowtie on the <span style=\"color: #D85040\">$PROJECT</span> project.</p>\n<p><img src=\"https://storage.googleapis.com/tony-bowtie-pics/tony-bowtie.svg\" alt=\"Tony Bowtie\"></p>\n</body></html>\nEOF\nsudo systemctl restart httpd"
}
backend-svc-name = "uat-app-backend-svc"
backed-protocol = "HTTP"