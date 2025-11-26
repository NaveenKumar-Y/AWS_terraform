
backend_bucket_prefix = "state-file-bucket"

ingress_rules = [{
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }]
#   {
#     from_port   = -1
#     to_port     = -1
#     protocol    = "icmp"
#     cidr_blocks = ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 9090,
#     "to_port" : 9090,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 9100,
#     "to_port" : 9100,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 3000,
#     "to_port" : 3000,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 9093,
#     "to_port" : 9093,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 9091,
#     "to_port" : 9091,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 8080,
#     "to_port" : 8080,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 4317,
#     "to_port" : 4317,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 4318,
#     "to_port" : 4318,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 16686,
#     "to_port" : 16686,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 14268,
#     "to_port" : 14268,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 3200,
#     "to_port" : 3200,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 3100,
#     "to_port" : 3100,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 9080,
#     "to_port" : 9080,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   },
#   {
#     "from_port" : 8088,
#     "to_port" : 8088,
#     "protocol" : "tcp",
#     "cidr_blocks" : ["0.0.0.0/0"]
#   }
# ]



script_version = "7.0"
