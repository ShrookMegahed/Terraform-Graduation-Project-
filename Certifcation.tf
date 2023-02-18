/* # The entire section create a certiface, public zone, and validate the certificate using DNS method

# Create the certificate using a wildcard for all the domains created in bulwm.click
resource "aws_acm_certificate" "bulwm" {
  domain_name       = "*.bulwm.click"
  validation_method = "DNS"
}

# calling the hosted zone
data "aws_route53_zone" "bulwm" {
  name         = "bulwm.click"
  private_zone = false
}

# selecting validation method
resource "aws_route53_record" "bulwm" {
  for_each = {
    for dvo in aws_acm_certificate.bulwm.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.bulwm.zone_id
}

# validate the certificate through DNS method
resource "aws_acm_certificate_validation" "bulwm" {
  certificate_arn         = aws_acm_certificate.bulwm.arn
  validation_record_fqdns = [for record in aws_route53_record.bulwm : record.fqdn]
}
*/
