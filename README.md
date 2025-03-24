# Dein Geheimnis ist bei mir sicher

## Beschreibung

Für Infrastructure as Code (IaC) gibt es viele Lösungen und sie machen das Leben gerade in Cloud-Umgebungen angenehm. Selbst komplexe Softwaresysteme, die zahlreiche Ressourcen benötigen können Dank der formalen Beschreibungen teilweise vollautomatische bereitgestellt, deren Zustand verifiziert und wieder gelöscht werden.

Bei vielen der verwendete Ressourcen fallen allerdings Passwörter und Schlüsselmaterial an, die entweder für deren Erstellung oder Nutzung gehandhabt werden müssen. Im Git-Repository möchte man die sensible Informationen nicht unverschlüsselt aufbewahren. Passwörter und Schlüssel sollten ggf. schnell ausgetauscht werden ohne einen Eingriff in automatisierte Abläufe zu benötigen.

Dafür gibt es mittlerweile diverse Projekte und Produkte, die verschiedenen Ansätzen eine Integration anbieten. Im Vortrag soll es um einen Überblick über verschiedene Lösungen die sowohl in der Cloud als auch im Homelab mit bspw. Ansible, Terraform/Opentofu und Kubernetes genutzt werden können.

**Erwünschte Vorkenntnisse:**
* Interesse an Infrastrukturaufbau/-organsiation
* Grundlegende Kenntnisse mit Ansible, Terraform/Opentofu, Kubernetes oder ähnlichen IaC-Tools wären von Vorteil um den Einsatzzweck zu verstehen

## Demo

Für das Demo wird [Vagrant](https://www.vagrantup.com/) benötigt. Behandelte Lösungen sind dabei

* [Ansible Vault](https://docs.ansible.com/ansible/latest/vault_guide/vault.html)
* [Bitnami Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets)
* [HashiCorp Vault](https://www.vaultproject.io/)
* [SOPS](https://getsops.io/)


Die Vagrant Box provisioniert am Anfang alle Tools und Services. Zum Start folgendes ausführen:

```sh
# Vagrant Box starten und provisionieren
cd demo
vagrant up
```

Bei der Provisionierung werden mehrere Skripte und unterteilt sich in drei Abschnitte.

Zuerst werde die Basisdienste & Tools installiert

* `install-k3s.sh`: Installiert einen Kubernetes cluster
* `install-tools.sh`: Installiert die verschiedene Tools wie `ansible`, `helm`, `sops`, etc.
* `install-sealed-secrets.sh`: Installiert Bitnami Sealed Secrets
* `install-vault.sh`: Installiert HashiCorp Vault

Danach werden die Secrets und Konfiguration vorbereitet:

* `prepare-ansible-vault.sh`
* `prepare-sealed-secrets.sh`
* `prepare-sops.sh`
* `prepare-vault.sh`

Am Ende werden die Beispiele für Ansible, Kubernetes und Terraform angewendet

* `run-ansible.sh`
* `run-kubernetes.sh`
* `run-terraform.sh`

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
