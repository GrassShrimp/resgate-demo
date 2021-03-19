resource "helm_release" "nats-operator" {
  name       = "nats-operator"
  repository = "https://nats-io.github.io/k8s/helm/charts/"
  chart      = "nats-operator"
  version    = "0.7.4"
  namespace  = "nats-io"

  values = [
    <<EOF
    cluster:
      create: true
      name: nats-cluster
      auth:
        enabled: false
      tls:
        enabled: false
    EOF
  ]

  create_namespace = true

  depends_on = [ kind_cluster.resgate-nats ]
}