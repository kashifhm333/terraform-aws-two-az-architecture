data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = [ "amazon" ]
  
}

resource "aws_launch_template" "app_template" {
    name_prefix = "${var.project_name}-app-template-"
    image_id = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type

    vpc_security_group_ids = [var.app_sg_id]
    user_data = base64encode(<<-EOF
              #!/bin/bash

              dnf update -y

              dnf install -y httpd

              systemctl enable httpd
              systemctl start httpd

              echo "<h1>Hello from $(hostname)</h1>" > /var/www/html/index.html
              EOF
  )
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-app"
    }
  }


}

resource "aws_autoscaling_group" "app-as" {
  name = "${var.project_name}-app-as"
  max_size = 3
  min_size = 1
  desired_capacity = 2
  vpc_zone_identifier = var.private_app_subnet_ids
  target_group_arns = [aws_launch_template.app_template.vpc_security_group_ids[0]]
  launch_template {
    id = aws_launch_template.app_template.id
    version = "$Latest"
  }
  
}