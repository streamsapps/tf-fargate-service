variable "region" {
  description = "aws region for dns name"
}

variable "service_name" {
  description = "The prefix for the service name."
}

variable "cluster_name" {
  description = "The ECS cluster to target for deployment."
}

variable "iam_role" {
  description = "The IAM service role for the ECS service"
}

variable "desired_count" {
  description = "The desired count for tasks to run in the service."
}

variable "deployment_minimum_healthy_percent" {
  description = "Minimum healthy percent for the service tasks."
}

variable "deployment_maximum_percent" {
  description = "The maximum percent for the service tasks."
}

variable "container_name" {
  description = "The container name in the task to target on the load balancer."
}

variable "container_port" {
  description = "The container port in the task to target on the load balancer."
}

variable "task_family" {
  description = "The name of the task family to use for task definitions."
}

variable "network_mode" {
  default     = "awsvpc"
  description = "defines the network mode the task definition runs in; valid values are bridge and host."
}

variable "cpu" {
  default     = 256
  description = "The number of cpu units used by the task"
}

variable "memory" {
  default     = 512
  description = "The amount (in MiB) of memory used by the task"
}

variable "container_definitions" {
  description = "The JSON task definition (this would be the task.json template file that is already rendered)"
}

variable "load_balancer_name" {
  description = "The name for the load balancer"
}

variable "alb_internal" {
  default = "false"  
  description = "If true, the LB will be internal."
}

variable "service_security_groups" {
  description = "The security groups for the load balancer"
}

variable "service_subnets" {
  description = "The subnets for the load balancer"
}

variable "alb_security_groups" {
  description = "The security groups for the load balancer"
}

variable "alb_subnets" {
  description = "The subnets for the load balancer"
}

variable "target_group_name" {
  description = "The name of the target group"  
}

variable "load_balancer_target_protocol" {
  default     = "HTTP"
  description = "The target protocol for the load balancer"
}

variable "load_balancer_target_port" {
  default     = "80"
  description = "The target port for the load balancer"
}

variable "vpc_id" {
  description = "The VPC ID"
}

variable "deregistration_delay" {
  description = "Target group deregistration delay"
}

variable "healthcheck_interval_seconds" {
  description = "Target group health check interval"
}

variable "healthcheck_path" {
  description = "Target group health check path"
}

variable "healthcheck_protocol" {
  description = "Target group health check protocol"
}

variable "app_scaling_maximum" {
  default     = 5
  description = "Maximum number of tasks that will be running; the service will not scale above this."
}

variable "app_scaling_minimum" {
  default     = 2
  description = "The minimum number of tasks that will be running; it will not scale below this."
}

variable "app_scaling_cooldown" {
  default     = 120
  description = "The number of seconds to wait between scaling events (both scale up and scale down)"
}

variable "app_alarm_cpu_high_evaluation_period_seconds" {
  default     = 60
  description = "the length of time in seconds that an evaluation period is defined"
}

variable "app_alarm_cpu_high_num_evaluation_periods" {
  default     = 2
  description = "The number of evaluation periods that must be above the defined threshold to scale up. "
}

variable "app_alarm_cpu_high_threshold" {
  default     = 200
  description = "see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#service_utilization for more info"
}

variable "app_alarm_cpu_low_evaluation_period_seconds" {
  default     = 60
  description = "the length of time in seconds that an evaluation period is defined"
}

variable "app_alarm_cpu_low_num_evaluation_periods" {
  default     = 2
  description = "The number of evaluation periods that must be below the defined threshold to scale down. "
}

variable "app_alarm_cpu_low_threshold" {
  default     = 20
  description = "see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#service_utilization for more info"
}

variable "app_alarm_memory_high_evaluation_period_seconds" {
  default     = 60
  description = "the length of time in seconds that an evaluation period is defined"
}

variable "app_alarm_memory_high_num_evaluation_periods" {
  default     = 2
  description = "The number of evaluation periods that must be above the defined threshold to scale up. "
}

variable "app_alarm_memory_high_threshold" {
  default     = 200
  description = "see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#service_utilization for more info"
}

variable "app_alarm_memory_low_evaluation_period_seconds" {
  default     = 60
  description = "the length of time in seconds that an evaluation period is defined"
}

variable "app_alarm_memory_low_num_evaluation_periods" {
  default     = 2
  description = "The number of evaluation periods that must be below the defined threshold to scale down. "
}

variable "app_alarm_memory_low_threshold" {
  default     = 20
  description = "see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#service_utilization for more info"
}
