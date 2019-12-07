# Truss Examples

This repository aims to capture a number of examples which demonstrate different solutions and mechanisms which incorporate the truss tool set into continuous integration and delivery of code.

## Examples

### Test Admission Control

An example where `anchorctl` is used to test the Admission Control functionality of Kubernetes. The example focuses on templating policies, unit testing and integration testing OPA. It was developed as part of the Kube-Forum Sydney 2019 talk which can be found [here](https://github.com/trussio/truss-demos/tree/master/kube-forum-2019).

The following technologies are used:
- **Rego** to write the policies
- **Jinja2** and **PyYAML** to template policies and unit tests
- **OPA + Kube Mgmt** as the validating and mutating admission controller
- **Kustomize** to generate configmaps of policies
- **Anchorctl** to perform integration testing of the policies

More information about the demo can be found [here](./examples/test-admission-controller/README.md)

## Pipelines

Examples which demonstrate an end-to-end pipeline integration

### Tekton

### Cloud Build