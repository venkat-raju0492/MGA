region = "" //aws region
project = "" //name of the project
environment = "" //name of the environment
domain_name = "" //domain name ex: mgm-site.com
cf_certificate_arn_no = "" //cloudfront cert arn no ex: 2b7825eb-1084-4243-a8fx-724bd9212988
vpc_id = "" //vpc ID
frontend_allowed_cidrs = [] 
backend_allowed_cidrs = []
frontend_lb_allowed_cidrs = []
waf_cidr_allowlist = []
ssl_method = "sni-only"
protocol_version = "TLSv1.2_2019"
allow_methods = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
cache_methods = ["GET","HEAD"]
static_s3_expiration_days = "90"
deregistration_delay = "20"
health_check_path = ""
public_subnet_ids = []
certificate_arn_no = ""
frontend_ecr_repo = ""
frontend_image_tag = ""
frontend_memory = ""
frontend_cpu = ""
frontend_container_port = ""
ecs_launch_type = "FARGATE"
ecs_frontend_scheduling_strategy = "REPLICA"
private_subnet_ids = []
ecs_frontend_desired_count = "1"
backend_ecr_repo = ""
backend_image_tag = ""
backend_memory = ""
backend_cpu = ""
backend_container_port = ""
ecs_backend_scheduling_strategy = "REPLICA"
ecs_backend_desired_count = "1"
