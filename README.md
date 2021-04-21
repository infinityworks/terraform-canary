# terraform-canary

Module for Using AWS Cloudwatch Synthetics to build a canary for testing endpoints within your AWS architecture.

Modularised version of https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/synthetics_canary

Includes node version of synthetics lambda within the template folder that gets zipped up and deployed on apply.

Node version of the lambda allows usage of AWS X-Ray which really differntiates this from traditional heartbeat monitoring tools whilst using AWS.  