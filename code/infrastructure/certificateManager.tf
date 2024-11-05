resource "aws_acm_certificate" "certificate" {
  // We want a wildcard cert so we can host subdomains later.
  domain_name       = "*.${var.www_domain_name}"
  validation_method = "DNS"

  // We also want the cert to be valid for the root domain even though we'll be
  // redirecting to the www. domain immediately.
  subject_alternative_names = ["${var.www_domain_name}"]
}