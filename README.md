## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alb\_internal | If true, the LB will be internal. | string | `"false"` | no |
| alb\_security\_groups | The security groups for the load balancer | list | n/a | yes |
| alb\_subnets | The subnets for the load balancer | list | n/a | yes |
| app\_alarm\_cpu\_high\_evaluation\_period\_seconds | the length of time in seconds that an evaluation period is defined | string | `"60"` | no |
| app\_alarm\_cpu\_high\_num\_evaluation\_periods | The number of evaluation periods that must be above the defined threshold to scale up. | string | `"2"` | no |
| app\_alarm\_cpu\_high\_threshold | see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#service_utilization for more info | string | `"200"` | no |
| app\_alarm\_cpu\_low\_evaluation\_period\_seconds | the length of time in seconds that an evaluation period is defined | string | `"60"` | no |
| app\_alarm\_cpu\_low\_num\_evaluation\_periods | The number of evaluation periods that must be below the defined threshold to scale down. | string | `"2"` | no |
| app\_alarm\_cpu\_low\_threshold | see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#service_utilization for more info | string | `"20"` | no |
| app\_alarm\_memory\_high\_evaluation\_period\_seconds | the length of time in seconds that an evaluation period is defined | string | `"60"` | no |
| app\_alarm\_memory\_high\_num\_evaluation\_periods | The number of evaluation periods that must be above the defined threshold to scale up. | string | `"2"` | no |
| app\_alarm\_memory\_high\_threshold | see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#service_utilization for more info | string | `"200"` | no |
| app\_alarm\_memory\_low\_evaluation\_period\_seconds | the length of time in seconds that an evaluation period is defined | string | `"60"` | no |
| app\_alarm\_memory\_low\_num\_evaluation\_periods | The number of evaluation periods that must be below the defined threshold to scale down. | string | `"2"` | no |
| app\_alarm\_memory\_low\_threshold | see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#service_utilization for more info | string | `"20"` | no |
| app\_scaling\_cooldown | The number of seconds to wait between scaling events (both scale up and scale down) | string | `"120"` | no |
| app\_scaling\_maximum | Maximum number of tasks that will be running; the service will not scale above this. | string | `"5"` | no |
| app\_scaling\_minimum | The minimum number of tasks that will be running; it will not scale below this. | string | `"2"` | no |
| cluster\_name | The ECS cluster to target for deployment. | string | n/a | yes |
| container\_definitions | The JSON task definition (this would be the task.json template file that is already rendered) | string | n/a | yes |
| container\_name | The container name in the task to target on the load balancer. | string | n/a | yes |
| container\_port | The container port in the task to target on the load balancer. | string | n/a | yes |
| cpu | The number of cpu units used by the task | string | `"256"` | no |
| deployment\_maximum\_percent | The maximum percent for the service tasks. | string | n/a | yes |
| deployment\_minimum\_healthy\_percent | Minimum healthy percent for the service tasks. | string | n/a | yes |
| deregistration\_delay | Target group deregistration delay | string | n/a | yes |
| desired\_count | The desired count for tasks to run in the service. | string | n/a | yes |
| healthcheck\_interval\_seconds | Target group health check interval | string | n/a | yes |
| healthcheck\_path | Target group health check path | string | n/a | yes |
| healthcheck\_protocol | Target group health check protocol | string | n/a | yes |
| iam\_role | The IAM service role for the ECS service | string | n/a | yes |
| load\_balancer\_name | The name for the load balancer | string | n/a | yes |
| load\_balancer\_target\_port | The target port for the load balancer | string | `"80"` | no |
| load\_balancer\_target\_protocol | The target protocol for the load balancer | string | `"HTTP"` | no |
| memory | The amount (in MiB) of memory used by the task | string | `"512"` | no |
| network\_mode | defines the network mode the task definition runs in; valid values are bridge and host. | string | `"awsvpc"` | no |
| region | aws region for dns name | string | n/a | yes |
| service\_name | The prefix for the service name. | string | n/a | yes |
| service\_security\_groups | The security groups for the fargate service | list | n/a | yes |
| service\_subnets | The subnets for the fargate service | list | n/a | yes |
| ssl\_certificate\_id | Load balancer SSL certificate arn | string | `""` | no |
| ssl\_policy | The load balancer SSL policy | string | `""` | no |
| target\_group\_name | The name of the target group | string | n/a | yes |
| task\_family | The name of the task family to use for task definitions. | string | n/a | yes |
| vpc\_id | The VPC ID | string | n/a | yes |

