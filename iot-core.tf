resource "aws_iot_certificate" "cert" {
  active = true
}

resource "aws_iot_thing" "thing_number_one" {
  name = "thing_number_one"

  attributes = {
    First = "thing_number_one"
  }
}

resource "aws_iot_thing_principal_attachment" "attachment" {
  principal = aws_iot_certificate.cert.arn
  thing     = aws_iot_thing.thing_number_one.name
}

data "aws_iot_endpoint" "iot_endpoint" {
  endpoint_type = "iot:Data-ATS"
}