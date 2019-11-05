provider "docker" {
}

resource "docker_container" "whisky" {
	image = "${docker_image.whisky.latest}"
	name = "app"
	ports {
		internal = 9090
		external = 9090
	}
}

resource "docker_image" "whisky" {
	name = "okal/whisky:latest"
}
