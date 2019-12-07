package system

deny[msg] {
    input.request.resource.resource = "services"
    input.request.object.spec.type = "LoadBalancer"
    not hasAnnotationValue(input.request.object, "cloud.google.com/load-balancer-type", "Internal")
    isCreateOrUpdate
    msg := "External Loadbalancers cannot be deployed in this cluster"
}

deny[msg] {
    namespaces := ["ingress"]
    input.request.resource.resource = "services"
    input.request.object.spec.type = "LoadBalancer"
    hasAnnotationValue(input.request.object, "cloud.google.com/load-balancer-type", "Internal")
    input.request.namespace != namespaces[_]
    isCreate
    msg := sprintf("Internal Loadbalancers cannot be deployed to %s namespace", [input.request.namespace])
}
