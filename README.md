# Helm Chart Repository

Helm chart repository for my GitHub projects.

## Usage

[Helm](https://helm.sh) must be installed to use the charts. Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

```shell
helm repo add jasonshobe https://jasonshobe.github.io/helm-charts
```

If you had already added this repo earlier, run `helm repo update` to
retrieve the latest versions of the packages. You can then run
`helm search repo jasonshobe` to see the charts.

## Hosted Charts

* [ecr-cred-helper](./charts/ecr-cred-helper/README.md)

