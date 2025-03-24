terraform {
  backend "kubernetes" {
    secret_suffix    = "state"
    config_path      = "~/.kube/config"
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.36.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "4.6.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.1.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}

provider "sops" {}

provider vault {
  address = "http://vault.demo.local"
}

# vim: expandtab tabstop=2 shiftwidth=2 ft=hcl
