provider "aws" {
  region = "${var.region}"
}

resource "aws_ecs_service" "fargate-service" {
  name                               = "${var.service_name}"
  cluster                            = "${var.cluster_name}"
  task_definition                    = "${aws_ecs_task_definition.fargate-task.arn}"
  desired_count                      = "${var.desired_count}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"
  launch_type                        = "FARGATE"

  load_balancer {
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
    container_name   = "${var.container_name}"
    container_port   = "${var.container_port}"
  }

  network_configuration {
    assign_public_ip = "true"
    subnets          = ["${var.service_subnets}"]
    security_groups  = ["${var.service_security_groups}"]
  }
}

resource "aws_ecs_task_definition" "fargate-task" {
  family                   = "${var.task_family}"
  container_definitions    = "${var.container_definitions}"
  task_role_arn            = "${data.aws_iam_role.role.arn}"
  execution_role_arn       = "${data.aws_iam_role.role.arn}"
  cpu                      = "${var.cpu}"
  memory                   = "${var.memory}"
  network_mode             = "${var.network_mode}"
  requires_compatibilities = ["FARGATE"]
}

data "aws_iam_role" "role" {
  name = "${var.iam_role}"
}
