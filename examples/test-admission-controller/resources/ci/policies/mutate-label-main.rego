package system

############################################################
# PATCH rules
#
# Note: All patch rules should start with `isValidRequest` and `isCreateOrUpdate`
############################################################

mutateLabelResourceList = ["deployments", "jobs", "cronjobs", "replicasets"]

patch [patchCode] {
    isValidRequest
	isCreateOrUpdate
	input.request.resource.resource = mutateLabelResourceList[_]
    input.request.namespace = "something"
    patchCode = { "op": "add", "path": "/metadata/labels/something.is", "value": "labels" }

}

