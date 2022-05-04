# POLICIES:
# POLICY 1 == Assume Role
data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
# ROLE
resource "aws_iam_role" "dashboard_server_role" {
  name               = "dashboard_server_role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}
# POLICY 2 == PERMISSIONS TO ACCESS DATABASE
data "aws_iam_policy_document" "Access_WordPress_Database" {
  statement {
    sid = "secretDBWordpressAccess"
    actions = [
        "Resource": [ 
                "data.aws_secretsmanager_secret.WordPress_DB_secrets.arn"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetSecretValue",
    ]
  }
}
#resource "aws_iam_policy" "list_subnets_instances" {
  #name        = "list-all-instances-policy"
  #description = "List all instances and subnets for our dashboard"
  #policy      = data.aws_iam_policy_document.list_subnets_and_instances_doc.json
}
# POLICY 3 == ACCESS WORDPRESS DATABASE
data "aws_secretsmanager_secret" "WordPress_DB_secrets" {
  name = "database-credentials"
}
# ATTACH ALL POLICIES TO THE ROLE
resource "aws_iam_role_policy_attachment" "list_instances_atch" {
  role       = aws_iam_role.dashboard_server_role.name
  policy_arn = aws_iam_policy.list_subnets_instances.arn
}
# CREATE AN INSTANCE PROFILE FROM THE ROLE
resource "aws_iam_instance_profile" "dashboard_server_profile" {
  name = "dashboard_server_profile"
  role = aws_iam_role.dashboard_server_role.name
}
# ACCESS WORDPRESS DATABASE PASSWORD POLICY
resource "database-credentials" "WordPress_DB_secrets" {
  name = "dashboard_server_profile"
  role = aws_iam_role.dashboard_server_role.name
}