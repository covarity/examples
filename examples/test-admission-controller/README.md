# Test Admission Controller

Test admission controller emphasizes the important of
- Templating policy
- Templating unit tests
- Integration testing admission controller policies

The slides for the talk about the code can be found [here][talk].

### Getting Started

- Install **OPA** cli
- Install **Jinja2** and **PyYAML**
- Install **Kustomize**
- Bootstrap a kubernetes cluster

An overview of the folder structure can be found [here](#directory-structure).

### Apply policies
The sample policies in the `policies/` directory are:
- `common`: Common Rego function which can be used within other policies.
- `lb-services`: Policies which prevents deploying ingresses by accident and templates which namespace an internal loadbalancer can be deployed to. Acts as a developer guardrail in case of accidental creation of loadbalancers.
- `mutate-affinity`: Policies which isolate workload onto nodepools depending on namespaces.
- `mutate-label`: Policies which add custom labels to workloads in specific namespaces.

To deploy a version of these policies to your cluster:
- Create a YAML file in `values/` folder with `{YOUR_CLUSTER_NAME}`.
- Input values you would like for the policies mentioned above. An example is provided in `values/ci.yaml`
- Run `make generate.manifests CLUSTER={YOUR_CLUSTER_NAME}` to generate rego policies with your custom values, unit test them and use kustomize to generate versioned configmaps into the folder `resources/{YOUR_CLUSTER_NAME}/manifests/{YOUR_VERSION}/output.yaml`

### Run Integration tests
- Copy `test/anchor_test_ci.yaml` and paste into `test/anchor_test_{YOUR_CLUSTER_NAME}.yaml
- Change values to suit your policy needs. To find out more about `anchorctl` tests [here][anchorctl]

### Make Entries

```bash
generate.policies    Generate OPA policies into resources/${CLUSTER}/policies eg. make generate.policies CLUSTER=ci
generate.manifests   Generate kube configmaps from OPA policies that end with -main.rego eg. make generate.manifests CLUSTER=ci
deploy.prereqs       Deploy OPA + kube-mgmt into the cluster eg. make deploy.prereqs CLUSTER=ci
deploy               Deploy the OPA policy configmaps in the cluster eg. make deploy CLUSTER=ci
test.unit            Test generated OPA policies eg. make test.unit CLUSTER=ci
test.coverage        Test coverage of OPA policies eg. make test.coverage CLUSTER=ci
test.integration     Integration test OPA policies with anchorctl eg. make test.integration CLUSTER=ci
clean                Delete auto-generated files under resouces/${CLUSTER} eg. make clean CLUSTER=ci
status               Status of OPA configmaps. eg. make status CLUSTER=ci
help                 List the Makefile Entries and a short description
```

## Directory Structure

```bash
.
├── Makefile                        // Make entry points for templating, testing and deploying policies
├── README.md
├── policies                        // List of Kubernetes policies which are templated
│   ├── common                      // OPA common library with functions used across policies
│   │   ├── common-data.j2
│   │   ├── common-main.j2
│   │   └── common-test.j2
│   ├── ...
├── prerequisites                   // Manifest to install OPA + kube-mgmt sidecar (Should not be used in production)
│   └── opa.yaml
├── resources                       // Resources generated for each environment
│   └── ci
│       ├── kustomization.yaml
│       ├── manifests
│       │   └── 0.1.0               // Versioned Configmap of OPA policies
│       │       └── output.yaml
│       └── policies                // jinja2 generated policies
├── test
│   └── anchor_test.yaml            // Anchor test file for OPA testing
└── values                          // Jinja2 values file for each environment
    └── ci.yaml
```

<!-- Links Ref -->
[talk]: https://github.com/trussio/truss-demos/tree/master/kube-forum-2019
[anchorctl]: https://github.com/trussio/anchorctl