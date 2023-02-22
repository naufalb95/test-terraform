data "aws_iam_policy_document" "sagemaker_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role" {
  name               = "DataAnalyst"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_policy.json
}

resource "aws_sagemaker_domain" "sagemaker_domain" {
  domain_name = "sagemaker-domain"
  auth_mode   = "IAM"
  vpc_id      = aws_vpc.vpc.id
  subnet_ids  = [aws_subnet.main_subnet.id]

  default_user_settings {
    execution_role = aws_iam_role.role.arn
  }

  default_space_settings {
    execution_role = aws_iam_role.role.arn
  }
}