resource "aws_iam_user" "user" {
  name = "echo-sample-deployer"
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::echo-sample-production-tfstate"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:prefix"

      values = [
        ""
      ]
    }
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::echo-sample-production-tfstate",
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "production",
        "production/*"
      ]
    }
  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::echo-sample-production-tfstate/production/*",
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "echo-sample-policy"
  description = "echo-sample policy"
  policy = "${data.aws_iam_policy_document.policy_document.json}"
}
