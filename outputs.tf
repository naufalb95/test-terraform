output "iot_endpoint" {
  value = data.aws_iot_endpoint.iot_endpoint.endpoint_address
}

output "aws_cert" {
  value     = aws_iot_certificate.cert.certificate_pem
  sensitive = true
}

output "aws_cert2" {
  value     = aws_iot_certificate.cert.ca_pem
  sensitive = true
}
