resource "kubernetes_namespace" "resgate" {
  metadata {
    name = "resgate"
  }
}

resource "kubernetes_service" "resgate" {
  metadata {
    name      = "resgate"
    namespace = kubernetes_namespace.resgate.metadata[0].name
  }

  spec {
    port {
      name        = "resgate"
      protocol    = "TCP"
      port        = 80
      target_port = "http"
    }

    selector = {
      app = "resgate"
    }

    type = "ClusterIP"
  }

  depends_on = [ kind_cluster.resgate-nats ]
}

resource "kubernetes_deployment" "resgate" {
  metadata {
    name      = "resgate"
    namespace = kubernetes_namespace.resgate.metadata[0].name

    labels = {
      app = "resgate"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "resgate"
      }
    }

    template {
      metadata {
        labels = {
          app = "resgate"
        }
      }

      spec {
        container {
          name  = "resgate"
          image = "resgateio/resgate:1.6.3"
          args  = ["--nats", "nats://nats-cluster.nats-io:4222"]

          port {
            name           = "http"
            container_port = 8080
          }
        }

        restart_policy = "Always"
      }
    }

    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_unavailable = "25%"
        max_surge       = "25%"
      }
    }
  }

  depends_on = [ kind_cluster.resgate-nats ]
}

resource "null_resource" "resgate-route" {
  provisioner "local-exec" {
    command = "kubectl apply -f resgate-route.yaml -n ${kubernetes_namespace.resgate.metadata[0].name}"
  }

  depends_on = [ null_resource.installing-istio ]
}