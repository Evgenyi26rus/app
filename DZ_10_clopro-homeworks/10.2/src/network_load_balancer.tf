resource "yandex_lb_network_load_balancer" "network-load-balancer" {
  name = "network-load-balancer"
  deletion_protection = "false"
  listener {
    name = "http"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp-instance.load_balancer[0].target_group_id
    healthcheck {
      name = "http"
      interval = 2
      timeout = 1
      unhealthy_threshold = 2
      healthy_threshold = 4
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}