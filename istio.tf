resource "null_resource" "installing-istio-operator" {
  provisioner "local-exec" {
    command = "istioctl operator init"
  }

  depends_on = [ kubernetes_config_map.metallb-config ]
}

resource "null_resource" "installing-istio" {
  provisioner "local-exec" {
    command = "kubectl create namespace istio-system"
  }

  provisioner "local-exec" {
    command = "kubectl apply -f ./istio-profile.yaml"
  }

  provisioner "local-exec" {
    command = "sleep 30"
  }

  provisioner "local-exec" {
    command = "kubectl wait deployment --all --timeout=-1s --for=condition=Available -n istio-system"
  }

  provisioner "local-exec" {
    command = "kubectl wait --for=condition=Established --all crd"
  }

  provisioner "local-exec" {
    when = destroy
    command = "kubectl delete -f ./istio-profile.yaml"
  }

  provisioner "local-exec" {
    when = destroy
    command = "kubectl delete namespace istio-system"
  }

  depends_on = [ null_resource.installing-istio-operator ]
}