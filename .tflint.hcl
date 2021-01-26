// https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/config.md
config {
  module = false
  force = false
}

// tflint rules: https://github.com/terraform-linters/tflint/tree/master/docs/rules#rules

rule "terraform_comment_syntax" {
  enabled = true 
}
