terraform {
  # Версия terraform
  required_version = "~> 0.12"
}

provider "google" {
  # Версия провайдера
  version = "2.15"

  # ID проекта
  project = "infra-271212"

  region = "europe-west-1"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "reddit-base"
    }
  }

  metadata {
    ssh-keys = "ivan:${file("~/.ssh/ivan.pub")}"
  }

  tags = ["reddit-app"]

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file("~/.ssh/appuser")}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}

resource "google_compute_project_metadata" "ssh_keys" {
  metadata = {
    #ssh-keys = "appuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}"
    ssh-keys = join("\n", [for user, key in var.project_ssh_keys : "${user}:${file(key)}"])
  }
}
