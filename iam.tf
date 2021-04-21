resource "aws_iam_role" "main" {
  name               = local.canary_name
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.main_assume.json
}

resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}

data "aws_iam_policy_document" "main_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "main"{
  name        = "synthetics-policy-${local.canary_name}"
  description = "Cloudwatch Synthetics Policy."
  policy      = data.aws_iam_policy_document.canary.json
}

data "aws_iam_policy_document" "canary" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.config.items.main.client}-canaries-${var.config.items.main.environment}/canary/${local.canary_name}/*"]
    actions   = ["s3:PutObject"]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.config.items.main.client}-canaries-${var.config.items.main.environment}"]
    actions   = ["s3:GetBucketLocation"]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:sqs:eu-west-2:${var.config.items.providers.aws_account_id}:log-group:/aws/lambda/"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:CreateLogGroup",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "s3:ListAllMyBuckets",
      "xray:PutTraceSegments",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions   = ["cloudwatch:PutMetricData"]

    condition {
      test     = "StringEquals"
      variable = "cloudwatch:namespace"
      values   = ["CloudWatchSynthetics"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
    ]
  }
}
