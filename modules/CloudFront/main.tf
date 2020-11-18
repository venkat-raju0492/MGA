resource "aws_cloudfront_origin_access_identity" "cf-origin-identity" {
  comment = var.cloudfront_origin_access_identity
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.bucket_regional_domain_name
    origin_id   = var.fqdn

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cf-origin-identity.cloudfront_access_identity_path
    }
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "${var.project}-cloudfront-${var.environment}"
    },
  )

  web_acl_id = var.waf_acl_id
  aliases = var.aliases

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.object_file

  default_cache_behavior {
    allowed_methods  = var.allow_methods
    cached_methods   = var.cache_methods
    target_origin_id = var.fqdn

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
    compress               = true
    viewer_protocol_policy = var.protocol_policy
  }

  custom_error_response {
    error_caching_min_ttl = var.error_ttl
    error_code            = var.error_code
    response_code         = var.response_code
    response_page_path    = var.response_path
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
    acm_certificate_arn            = var.cert_arn
    ssl_support_method             = var.ssl_method
    minimum_protocol_version       = var.protocol_version
  }
}