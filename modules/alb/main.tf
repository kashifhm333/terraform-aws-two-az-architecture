resource "aws_lb" "alb" {
    name = "${var.project_name}-alb"
    load_balancer_type = "application"
    internal = false
    subnets = var.public_subnet_ids
    security_groups = [ var.alb_sg_id ]
  
}

resource "aws_lb_target_group" "app_tg" {
    name = "${var.project_name}-app-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
      path = "/"
      protocol = "HTTP"
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 30
      interval = 30
      port = "traffic-port"
    }
  
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.app_tg.arn
    }
  
}