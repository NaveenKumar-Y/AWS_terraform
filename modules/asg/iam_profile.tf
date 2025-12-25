resource "aws_iam_instance_profile" "instance_profile" {
  name = "myapp_instance_profile"
  role = aws_iam_role.role.name
}

data "aws_iam_policy_document" "assume_role" {
    statement {
        effect = "Allow"

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }

        actions = ["sts:AssumeRole"]
    }
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
    role       = aws_iam_role.role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "role" {
  name               = "ssh_access_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}