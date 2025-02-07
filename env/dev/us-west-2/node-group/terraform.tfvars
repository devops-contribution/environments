node_group_name = "terraform-node-group"
instance_types  = ["t3.large"]
desired_size    = 2
max_size        = 2
in_size         = 1
bucket_name     = "terraform-remote-be-bucket"
region          = "us-west-2"
