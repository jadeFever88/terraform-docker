terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name 
  
  ports {
    internal = 80
    external = var.external_port
  }

  volumes {
    host_path      = "${abspath(path.module)}/index.html"
    container_path = "/usr/share/nginx/html/index.html"
  }
}


output "container_id" {
  description = "ID створеного контейнера"
  value       = docker_container.nginx.id
}

output "web_url" {
  description = "Посилання на сайт"
  value       = "http://localhost:${var.external_port}"
}
