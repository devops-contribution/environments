region                 = "us-west-2"
vpc_cidr               = "10.0.0.0/16"
private_subnet_az1_cidr = "10.0.1.0/24"
private_subnet_az2_cidr = "10.0.2.0/24"
public_subnet_nat_cidr  = "10.0.3.0/24"
ssh_access             = ["0.0.0.0/0"]
http_access            = ["0.0.0.0/0"]
instance_size          = "t3.large"
