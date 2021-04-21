resource "aws_synthetics_canary" "main" {
  name                 = local.canary_name
  artifact_s3_location = "s3://${local.canary_bucket}/canary/${local.canary_name}"
  execution_role_arn   = aws_iam_role.main.arn
  handler              = "apiCanaryBlueprint.handler"
  start_canary         = true
  zip_file             = "/tmp/canary_zip_inline.zip"
  runtime_version      = "syn-nodejs-puppeteer-3.1"
  
  # VPC Config
  # vpc_config {
  #   subnet_ids         = 
  #   security_group_ids = 
  # }

    run_config {
    active_tracing = true
    timeout_in_seconds = 60
  }

  schedule {
    expression = "rate(5 minutes)"
  }

}

data "archive_file" "canary_zip_inline" {
  type        = "zip"
  output_path = "/tmp/canary_zip_inline.zip"
  
  source {
    content  = templatefile("${path.module}/templates/canary_node.tmpl", {
      endpoint = var.endpoint
    })
    filename = "nodejs/node_modules/apiCanaryBlueprint.js"
  }
}
