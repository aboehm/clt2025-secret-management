locals {
  app-sops = "simple-app-with-sops"
}

data "sops_file" "sops-secret" {
  source_file = "../sops-secret.txt"
  input_type  = "json"
}

# vim: expandtab tabstop=2 shiftwidth=2 ft=hcl
