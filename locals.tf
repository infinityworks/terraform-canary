locals {
    canary_bucket = "${var.config.items.main.client}-canaries-${var.config.items.main.environment}"
    canary_name = "${var.name}-${var.config.items.main.environment}"
}
