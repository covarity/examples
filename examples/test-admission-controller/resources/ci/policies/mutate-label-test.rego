package system

import data.library.kubernetes.admission.mutate.label.test as mutatelabel

#-----------------------------------------------------------
# Test: something patch
#-----------------------------------------------------------

test_something_label_patch {
	res := main with input as mutatelabel.deploy_to_something
	res.response.allowed = true
	isPatchResponse(res)
	patches = json.unmarshal(base64.decode(res.response.patch))
	hasPatch(patches, mutatelabel.patch_code_for_something)
}

