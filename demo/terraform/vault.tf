locals {
  app-vault         = "simple-app-with-vault"
  vault-secret-name = "secret"
}

resource "random_password" "secret" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:? "
}

resource "vault_mount" "kvv2" {
  path        = "clt2025-tf"
  type        = "kv"
  options     = {
    version = "2"
  }
  description = "KV Version 2 secret engine mount"
}

resource "vault_kv_secret_v2" "kvv2-secret" {
  mount = vault_mount.kvv2.path
  name  = "secret"
  data_json = jsonencode(
    {
      "${local.vault-secret-name}" = "A generated password ${random_password.secret.result}"
    }
  )
}
