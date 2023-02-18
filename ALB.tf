# External loadbalancer
resource "aws_lb" "ext-alb" {
  name               = "ext-alb"
  internal           = false
  security_groups    = [aws_security_group.ext_alb_sg.id]
  subnets           = [for subnet in aws_subnet.public : subnet.id]
  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
  tags = {
    Name = "ext_alb"
  }
  }

# --- create a target group for the external load balancer
resource "aws_lb_target_group" "nginx-tgt" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "nginx-tgt"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id
}


# --- create listener for load balancer
resource "aws_lb_listener" "nginx-listner" {
  load_balancer_arn = aws_lb.ext-alb.arn
  /* certificate_arn   = aws_acm_certificate_validation.bulwm.certificate_arn */
  port              = 443
  protocol          = "HTTPS"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-tgt.arn
  }
}


#Internal Load Balancers for webservers

resource "aws_lb" "internal_alb" {
  name     = "int-alb"
  internal = true
  security_groups = [aws_security_group.int-alb-sg.id]
   subnets = [for subnet in aws_subnet.private : subnet.id if subnet.cidr_block == "10.0.2.0/24" || subnet.cidr_block == "10.0.3.0/24"]
  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
  tags = {
    Name = "internal_alb"
  }
  }


  # --- target group  for webserver -------

resource "aws_lb_target_group" "webserver-tgt" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "webserver-tgt"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id
}

# For this aspect a single listener was created for the webserver which is default,
# A rule was created to route traffic to tooling when the host header changes

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 443
  protocol          = "HTTPS"
 /*  certificate_arn   = aws_acm_certificate_validation.bulwm.certificate_arn  */
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver-tgt.arn
  }
}
  