package system

#-----------------------------------------------------------
# Test: All denied resource should be rejected
#-----------------------------------------------------------

test_allow_nodeportService {
  nodeport_object := {"request": {
      "resource": {"resource": "services"},
      "object": {
          "spec": {
              "type": "NodePort"
          }
      }
  }}
  res := main with input as nodeport_object
  res.response.allowed = true
}

test_deny_externalLoadbalancer {
  external_loadbalaner_object := {"request": {
      "resource": {"resource": "services"},
      "operation": "CREATE",
      "object": {
          "spec": {
              "type": "LoadBalancer"
          }
      }
  }}
  res := main with input as external_loadbalaner_object
  res.response.allowed = false
}

test_deny_internalLoadbalancerwrongNamespace {
  internal_loadbalaner_wrong_namespace_object := {"request": {
      "resource": {"resource": "services"},
      "operation": "CREATE",
      "namespace": "NotARealNamespace",
      "object": {
          "metadata": {
              "annotations": {
                  "cloud.google.com/load-balancer-type": "Internal"
              }
          },
          "spec": {
              "type": "LoadBalancer"
          }
      }
  }}
  res := main with input as internal_loadbalaner_wrong_namespace_object
  res.response.allowed = false
}

test_allow_ingress {
  internal_loadbalancer_ingress := {"request": {
      "resource": {"resource": "services"},
      "operation": "CREATE",
      "namespace": "ingress",
      "object": {
          "metadata": {
              "annotations": {
                  "cloud.google.com/load-balancer-type": "Internal"
              }
          },
          "spec": {
              "type": "LoadBalancer"
          }
      }
  }}
  res := main with input as internal_loadbalancer_ingress
  res.response.allowed = true
}

