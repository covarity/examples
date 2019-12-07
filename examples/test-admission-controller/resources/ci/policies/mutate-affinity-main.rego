package system

############################################################
# PATCH rules
#
# Note: All patch rules should start with `isValidRequest` and `isCreateOrUpdate`
############################################################

mutateAffinityResources = ["deployments", "jobs", "cronjobs", "replicasets"]

mutateAffinityFunctionKey = "anchor.trussio/function"

patch [patchCode] {
    isValidRequest
	isCreateOrUpdate
    namespaces := ["istio-system","ops"]
	input.request.resource.resource = mutateAffinityResources[_]

	any([ bool | namespaces[_] = element; bool = startswith(input.request.namespace, element)])
    functionValue := "operation-tools"
    not hasAffinity(input.request.object.spec.template.spec, mutateAffinityFunctionKey, functionValue)
	patchCode = makeAffinityPatch(mutateAffinityFunctionKey, functionValue, input.request.object.spec.template.spec)
}

# Construct the patch object for the K8s Config for deployments
# Add affinity config if doesn't exist
makeAffinityPatch(functionKey, functionValue, spec) = {
        "op": "add",
        "path": "/spec/template/spec/affinity",
        "value": {
            "nodeAffinity": {
                "requiredDuringSchedulingIgnoredDuringExecution": {
                    "nodeSelectorTerms": [{
                        "matchExpressions": [{
                            "key": functionKey,
                            "operator": "In",
                            "values": [functionValue]
                        }]
                    }]
                }
            }
        }
    }  {
        not spec.affinity
    } else = {
        "op": "add",
        "path": "/spec/template/spec/affinity/nodeAffinity/requiredDuringSchedulingIgnoredDuringExecution",
        "value": {
            "nodeSelectorTerms": [{
                "matchExpressions": [{
                    "key": functionKey,
                    "operator": "In",
                    "values": [functionValue]
                }]
            }]
        }
    }  {
        not spec.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution
    } else =  {
        "op": "add",
        "path": "/spec/template/spec/affinity/nodeAffinity/requiredDuringSchedulingIgnoredDuringExecution/nodeSelectorTerms/0/matchExpressions",
        "value": [{
            "key": functionKey,
            "operator": "In",
            "values": [functionValue]
        }]
    }  {
        true
    }
