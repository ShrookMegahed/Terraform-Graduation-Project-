resource "aws_iam_role" "ec2_instance_role" {
name = "ec2_instance_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
tags = {
    Name = "ec2_instance_role"
  }
}


resource "aws_iam_policy" "iam_policy" {
  name        = "ec2-instance-policy"
  description = "My test policy for ec2-instance"



  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
  tags = {
    Name = "ec2_instance_policy"
  }
}

    resource "aws_iam_role_policy_attachment" "policy_attach" {
        role       = aws_iam_role.ec2_instance_role.name
        policy_arn = aws_iam_policy.iam_policy.arn
    }

    resource "aws_iam_instance_profile" "instance_profile" {
  name = "aws_instance_profile"
  role = aws_iam_role.ec2_instance_role.name
}

