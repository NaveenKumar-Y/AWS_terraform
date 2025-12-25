data "aws_caller_identity" "current" {}


# Archive a file to be used with Lambda using consistent file mode

data "archive_file" "lambda_my_function" {
  type             = "zip"
  source_file      = "${path.module}/my_function/hello.py"
  output_file_mode = "0666"
  output_path      = "${path.module}/my_function/lambda-hello.zip"
}

# IAM assume role policy for Lambda execution
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Create IAM role with assume role policy for Lambda execution
resource "aws_iam_role" "lambda_execution_role" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Create IAM policy(logs) for Lambda execution role
resource "aws_iam_policy" "lambda_policy" {
    name             = "lambda_policy"
    path             = "/"
    policy           = jsonencode(
        {
            Statement = [
                {
                    Action   = "logs:CreateLogGroup"
                    Effect   = "Allow"
                    Resource = "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:*"
                    Sid      = "CreateLogGroup"
                },
                {
                    Action   = [
                        "logs:CreateLogStream",
                        "logs:PutLogEvents",
                    ]
                    Effect   = "Allow"
                    Resource = "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:*:log-stream:*"
                    Sid      = "CreateLogStreamAndPutLogEvents"
                },
            ]
            Version   = "2012-10-17"
        }
    )

}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Create an AWS Lambda function

resource "aws_lambda_function" "my_function" {
  filename         = data.archive_file.lambda_my_function.output_path
  function_name    = "my_function"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "hello.lambda_handler"
  source_code_hash = data.archive_file.lambda_my_function.output_base64sha256  # Terrafomr is Lazy, it will not directly detect the zip file, we need to add source_code_hash

  runtime = "python3.8"

  environment {
    variables = {
      ENVIRONMENT = "development"
      LOG_LEVEL   = "info"
    }
  }

  tags = {
    Environment = "development"
    Application = "python_example"
  }
}