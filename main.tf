provider "docker" {
}

resource "docker_container" "db" {
	image = "${docker_image.db.latest}"
	name = "db"
	ports {
		internal = 5432
		external = 5432
	}

	networks_advanced {
		name = "${docker_network.whisky.name}"
	}

	volumes {
		host_path = "${path.cwd}/volumes/db/docker-entrypoint-initdb.d"
		container_path = "/docker-entrypoint-initdb.d"
	}
}

resource "docker_container" "whisky" {
	image = "${docker_image.whisky.latest}"
	name = "app"
	ports {
		internal = 9090
		external = 9090
	}

	env = ["DB_HOST=db", "DB_USER=postgres", "DB_NAME=whisky"]

	networks_advanced {
		name = "${docker_network.whisky.name}"
	}
}

resource "docker_image" "whisky" {
	name = "okal/whisky:latest"
}

resource "docker_image" "db" {
	name = "postgres:12.0-alpine"
}

resource "docker_network" "whisky" {
	name = "whisky"
}
