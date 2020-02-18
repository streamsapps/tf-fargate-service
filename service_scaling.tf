resource "aws_appautoscaling_target" "ecs_service" {
  max_capacity       = var.app_scaling_maximum
  min_capacity       = var.app_scaling_minimum
  resource_id        = "service/${aws_ecs_service.fargate-service.cluster}/${aws_ecs_service.fargate-service.name}"
  role_arn           = data.aws_iam_role.role.arn
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "service_scale_down" {
  name               = "${aws_ecs_service.fargate-service.name}-scale-down"
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.fargate-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.app_scaling_cooldown
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [aws_appautoscaling_target.ecs_service]
}

resource "aws_appautoscaling_policy" "service_scale_up" {
  name               = "${aws_ecs_service.fargate-service.name}-scale-up"
  resource_id        = "service/${aws_ecs_service.fargate-service.cluster}/${aws_ecs_service.fargate-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.app_scaling_cooldown
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [aws_appautoscaling_target.ecs_service]
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "${aws_ecs_service.fargate-service.name}-low-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.app_alarm_cpu_low_num_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.app_alarm_cpu_low_evaluation_period_seconds
  statistic           = "Average"
  threshold           = var.app_alarm_cpu_low_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = aws_ecs_service.fargate-service.name
  }

  alarm_description = "This metric monitors ${aws_ecs_service.fargate-service.name} low average CPU usage"
  alarm_actions     = [aws_appautoscaling_policy.service_scale_down.arn]

  depends_on = [aws_appautoscaling_policy.service_scale_down]
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${aws_ecs_service.fargate-service.name}-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.app_alarm_cpu_high_num_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.app_alarm_cpu_high_evaluation_period_seconds
  statistic           = "Average"
  threshold           = var.app_alarm_cpu_high_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = aws_ecs_service.fargate-service.name
  }

  alarm_description = "This metric monitors ${aws_ecs_service.fargate-service.name} high average CPU usage"
  alarm_actions     = [aws_appautoscaling_policy.service_scale_up.arn]

  depends_on = [aws_appautoscaling_policy.service_scale_up]
}

resource "aws_cloudwatch_metric_alarm" "low_memory" {
  alarm_name          = "${aws_ecs_service.fargate-service.name}-low-memory"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.app_alarm_memory_low_num_evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = var.app_alarm_memory_low_evaluation_period_seconds
  statistic           = "Average"
  threshold           = var.app_alarm_memory_low_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = aws_ecs_service.fargate-service.name
  }

  alarm_description = "This metric monitors ${aws_ecs_service.fargate-service.name} low average memory usage"
  alarm_actions     = [aws_appautoscaling_policy.service_scale_down.arn]

  depends_on = [aws_appautoscaling_policy.service_scale_down]
}

resource "aws_cloudwatch_metric_alarm" "high_memory" {
  alarm_name          = "${aws_ecs_service.fargate-service.name}-high-memory"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.app_alarm_memory_high_num_evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = var.app_alarm_memory_high_evaluation_period_seconds
  statistic           = "Average"
  threshold           = var.app_alarm_memory_high_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = aws_ecs_service.fargate-service.name
  }

  alarm_description = "This metric monitors ${aws_ecs_service.fargate-service.name} high average memory usage"
  alarm_actions     = [aws_appautoscaling_policy.service_scale_up.arn]

  depends_on = [aws_appautoscaling_policy.service_scale_up]
}

