# Dein Geheimnis ist bei mir sicher

## Beschreibung

Für Infrastructure as Code (IaC) gibt es viele Lösungen und sie machen das Leben gerade in Cloud-Umgebungen angenehm. Selbst komplexe Softwaresysteme, die zahlreiche Ressourcen benötigen können Dank der formalen Beschreibungen teilweise vollautomatische bereitgestellt, deren Zustand verifiziert und wieder gelöscht werden.

Bei vielen der verwendete Ressourcen fallen allerdings Passwörter und Schlüsselmaterial an, die entweder für deren Erstellung oder Nutzung gehandhabt werden müssen. Im Git-Repository möchte man die sensible Informationen nicht unverschlüsselt aufbewahren. Passwörter und Schlüssel sollten ggf. schnell ausgetauscht werden ohne einen Eingriff in automatisierte Abläufe zu benötigen.

Dafür gibt es mittlerweile diverse Projekte und Produkte, die verschiedenen Ansätzen eine Integration anbieten. Im Vortrag soll es um einen Überblick über verschiedene Lösungen die sowohl in der Cloud als auch im Homelab mit bspw. Ansible, Terraform/Opentofu und Kubernetes genutzt werden können.

**Erwünschte Vorkenntnisse:**
* Interesse an Infrastrukturaufbau/-organsiation
* Grundlegende Kenntnisse mit Ansible, Terraform/Opentofu, Kubernetes oder ähnlichen IaC-Tools wären von Vorteil um den Einsatzzweck zu verstehen

## Demo

Für das Demo wird [Vagrant](https://www.vagrantup.com/) benötigt. Die Vagrant Box provisioniert am Anfang alle Tools und Services. Zum Start folgendes ausführen:

```sh
cd demo
vagrant up
```

Behandelete Plattformen:

* [Ansible](https://docs.ansible.com/)
* [Kubernetes](https://kubernetes.io/)
* [Terraform](https://www.terraform.io/) / [OpenTofu](https://opentofu.org/)

Behandelte Lösungen:

* [Ansible Vault](https://docs.ansible.com/ansible/latest/vault_guide/vault.html)
* [Bitnami Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets)
* [detect-secrets](https://github.com/Yelp/detect-secrets)
* [HashiCorp Vault](https://www.vaultproject.io/)
* [SOPS](https://getsops.io/)

## Offene Punkte

* Demo Files sind noch nicht vollständig

## Slides

```sh
# Install revelation
pipx install revelation
# Show slides
revelation start slides.md
# Generate static slides
revelation mkstatic slides.md
```
