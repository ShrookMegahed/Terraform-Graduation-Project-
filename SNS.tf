# Creating sns topic for all the auto scaling groups
resource "aws_sns_topic" "project-sns" {
name = "Default_CloudWatch_Alarms_Topic"
}

# Creating notification for all the auto scaling groups
resource "aws_autoscaling_notification" "project_notifications" {
  group_names = [
    aws_autoscaling_group.bastion-sg.name,
    aws_autoscaling_group.nginx-sg.name,
    aws_autoscaling_group.webserver-sg.name,
  ]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.project-sns.arn
}
