data "aws_caller_identity" "current" {}

resource "aws_kms_key" "my_tf_kms_key" {
  description             = "my_tf_kms_key"
  enable_key_rotation     = true
  deletion_window_in_days = 20
}

resource "aws_kms_key_policy" "my_tf_kms_key_policy" {
  key_id = aws_kms_key.my_tf_kms_key.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_secretsmanager_secret" "secret-tf" {
  name       = "secret-tf"
  kms_key_id = aws_kms_key.my_tf_kms_key.id
}

variable "info" {
  default = {
    username = "User"
    password = "Password"
  }

  type = map(string)
}

resource "aws_secretsmanager_secret_version" "secret-version-tf" {
  secret_id     = aws_secretsmanager_secret.secret-tf.id
  secret_string = jsonencode(var.info)
}
