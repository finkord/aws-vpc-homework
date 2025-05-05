data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "EC2SecretManagerKMS" {
  name               = "EC2SecretManagerKMS"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}

resource "aws_iam_role_policy" "EC2SecretManagerKMS-policy" {
  name = "EC2SecretManagerKMS-policy"
  role = aws_iam_role.EC2SecretManagerKMS.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["secretsmanager:DescribeSecret", "secretsmanager:GetSecretValue"]
        Resource = aws_secretsmanager_secret.secret-tf.arn
        Effect   = "Allow"
      },
      {
        Action   = ["secretsmanager:GetSecretValue"]
        Resource = aws_secretsmanager_secret.secret-tf.arn
        Effect   = "Allow"
      },
      {
        Action   = ["kms:Decrypt"]
        Resource = aws_kms_key.my_tf_kms_key.arn
        Effect   = "Allow"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "profile" {
  name = "EC2SecretManagerKMS-profile"
  role = aws_iam_role.EC2SecretManagerKMS.name
}
