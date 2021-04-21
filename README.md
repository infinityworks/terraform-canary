# terraform-canary

Module for Using AWS Cloudwatch Synthetics to build a canary for testing endpoints within your AWS architecture.

Modularised version of https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/synthetics_canary

AWS Docs:- https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries.html

Costs around $10/USD/month for a check every 5 minutes using xray. 

Includes node version of synthetics lambda within the template folder that gets zipped up and deployed on apply.

Node version of the lambda allows usage of AWS X-Ray which really differntiates this from traditional heartbeat monitoring tools whilst using AWS. Can traverse the same network routes (using ACLs/SGs) as your applications
