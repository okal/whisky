provider "docker" {
}

resource "docker_container" "whisky" {
	image = "${docker_image.whisky.latest}"
	name = "app"
}

resource "docker_image" "whisky" {
	name = "whisky:latest"
}
