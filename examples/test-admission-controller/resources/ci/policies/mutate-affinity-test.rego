package system

import data.library.kubernetes.admission.mutate.affinty.test as mutatedata

#-----------------------------------------------------------
# Test: operation-tools patch
#-----------------------------------------------------------

test_makeAffinityPatch_noAffinity_istio_system {
	makeAffinityPatch("anchor.trussio/function", "operation-tools", mutatedata.no_affinity_istio_system.request.object.spec.template.spec, resp) with input as mutatedata.no_affinity_istio_system
	resp == mutatedata.patchCode_noAffinity_operation_tools
}

test_affinityPatch_noAffinity_istio_system {
	res := main with input as mutatedata.no_affinity_istio_system
	res.response.allowed = true
	isPatchResponse(res)
	patches = json.unmarshal(base64.decode(res.response.patch))
	hasPatch(patches, mutatedata.patchCode_noAffinity_operation_tools)
}

test_makeAffinityPatch_nodeAffinity_istio_system {
	makeAffinityPatch("anchor.trussio/function", "operation-tools", mutatedata.no_nodeAffinity_istio_system.request.object.spec.template.spec, resp) with input as mutatedata.no_nodeAffinity_istio_system
	resp == mutatedata.patchCode_nodeAffinity_operation_tools
}

test_affinityPatch_nodeAffinity_istio_system {
	res := main with input as mutatedata.no_nodeAffinity_istio_system
	res.response.allowed = true
	isPatchResponse(res)
	patches = json.unmarshal(base64.decode(res.response.patch))
	hasPatch(patches, mutatedata.patchCode_nodeAffinity_operation_tools)
}

test_makeAffinityPatch_matchExpression_istio_system {
	makeAffinityPatch("anchor.trussio/function", "operation-tools", mutatedata.no_matchExpression_istio_system.request.object.spec.template.spec, resp) with input as mutatedata.no_matchExpression_istio_system
	resp == mutatedata.patchCode_matchExpression_operation_tools
}

test_affinityPatch_matchExpression_istio_system {
	res := main with input as mutatedata.no_matchExpression_istio_system
	res.response.allowed = true
	isPatchResponse(res)
	patches = json.unmarshal(base64.decode(res.response.patch))
	hasPatch(patches, mutatedata.patchCode_matchExpression_operation_tools)
}

#-----------------------------------------------------------
# Test: operation-tools patch
#-----------------------------------------------------------

test_makeAffinityPatch_noAffinity_ops {
	makeAffinityPatch("anchor.trussio/function", "operation-tools", mutatedata.no_affinity_ops.request.object.spec.template.spec, resp) with input as mutatedata.no_affinity_ops
	resp == mutatedata.patchCode_noAffinity_operation_tools
}

test_affinityPatch_noAffinity_ops {
	res := main with input as mutatedata.no_affinity_ops
	res.response.allowed = true
	isPatchResponse(res)
	patches = json.unmarshal(base64.decode(res.response.patch))
	hasPatch(patches, mutatedata.patchCode_noAffinity_operation_tools)
}

test_makeAffinityPatch_nodeAffinity_ops {
	makeAffinityPatch("anchor.trussio/function", "operation-tools", mutatedata.no_nodeAffinity_ops.request.object.spec.template.spec, resp) with input as mutatedata.no_nodeAffinity_ops
	resp == mutatedata.patchCode_nodeAffinity_operation_tools
}

test_affinityPatch_nodeAffinity_ops {
	res := main with input as mutatedata.no_nodeAffinity_ops
	res.response.allowed = true
	isPatchResponse(res)
	patches = json.unmarshal(base64.decode(res.response.patch))
	hasPatch(patches, mutatedata.patchCode_nodeAffinity_operation_tools)
}

test_makeAffinityPatch_matchExpression_ops {
	makeAffinityPatch("anchor.trussio/function", "operation-tools", mutatedata.no_matchExpression_ops.request.object.spec.template.spec, resp) with input as mutatedata.no_matchExpression_ops
	resp == mutatedata.patchCode_matchExpression_operation_tools
}

test_affinityPatch_matchExpression_ops {
	res := main with input as mutatedata.no_matchExpression_ops
	res.response.allowed = true
	isPatchResponse(res)
	patches = json.unmarshal(base64.decode(res.response.patch))
	hasPatch(patches, mutatedata.patchCode_matchExpression_operation_tools)
}

