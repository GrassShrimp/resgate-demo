# resgate-demo

This is a demo for demonstrate websocket connect to resgate and sent request to backend service over nats

## Prerequisites

- [terraform](https://www.terraform.io/downloads.html)
- [docker](https://www.docker.com/products/docker-desktop)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start#installation)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [istioctl](https://istio.io/latest/docs/setup/getting-started/#download) or [brew install istioctl](https://formulae.brew.sh/formula/istioctl)
- [kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize)
- [skaffold](https://skaffold.dev/docs/install/)

## Usage

initialize terraform module

```bash
$ terraform init
```

set up enviroments with kind cluster, istio, resgate, and nats

```bash
$ terraform apply -auto-approve
```

setup examples server and client

```bash
$ cd examples/server && skaffold dev
$ cd examples/client && skaffold dev
```

and then open browser with url: localhost
![resgate01](https://github.com/GrassShrimp/resgate-demo/blob/master/resgate01.png)


## Reference

- [restgat.io](https://resgate.io/)
- [go-res/02-edit-text](https://github.com/jirenius/go-res/tree/master/examples/02-edit-text)