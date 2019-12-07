package system

import data.library.kubernetes.admission.common.test as commondata

############################################################
# PATCH helper tests
############################################################

#-----------------------------------------------------------
# Test: hasLabels is true when there are labels
#-----------------------------------------------------------
test_hasLabels_true {
	hasLabels(commondata.object_with_label_foo_bar)
}

#-----------------------------------------------------------
# Test: hasLabels is false when there are no labels
#-----------------------------------------------------------
test_no_labels_true {
	not hasLabels(commondata.object_without_labels)
}

#-----------------------------------------------------------
# Test: hasLabel is true when the label exists
#-----------------------------------------------------------
test_hasLabel_foo {
	hasLabel(commondata.object_with_label_foo_bar, "foo")
}

#-----------------------------------------------------------
# Test: hasLabel is false when the label doesn't exist
#-----------------------------------------------------------
test_not_hasLabel_foo1 {
	not hasLabel(commondata.object_with_label_foo_bar, "foo1")
}

#-----------------------------------------------------------
# Test: hasLabelValue is true when the label has the correct value
#-----------------------------------------------------------
test_hasLabelValue_fooeqbar {
	hasLabelValue(commondata.object_with_label_foo_bar, "foo", "bar")
}

#-----------------------------------------------------------
# Test: hasAnnotations is true when there are annotations
#-----------------------------------------------------------
test_hasAnnotations_true {
	hasAnnotations(commondata.object_with_annotation_foo_bar)
}

#-----------------------------------------------------------
# Test: hasAnnotations is false when there are no annotations
#-----------------------------------------------------------
test_no_annotations_true {
	not hasAnnotations(commondata.object_without_annotations)
}

#-----------------------------------------------------------
# Test: hasAnnotation is true when the annotation exists
#-----------------------------------------------------------
test_hasAnnotation_foo {
	hasAnnotation(commondata.object_with_annotation_foo_bar, "foo")
}

#-----------------------------------------------------------
# Test: hasAnnotation is false when the annotation doesn't exist
#-----------------------------------------------------------
test_not_hasAnnotation_foo1 {
	not hasAnnotation(commondata.object_with_annotation_foo_bar, "foo1")
}

#-----------------------------------------------------------
# Test: hasAnnotationValue is true when the annotation has the correct value
#-----------------------------------------------------------
test_hasAnnotationValue_fooeqbar {
	hasAnnotationValue(commondata.object_with_annotation_foo_bar, "foo", "bar")
}

#-----------------------------------------------------------
# Test: inputPathExists is true when path exists on the object
#-----------------------------------------------------------
test_inputPathExists {
	inputPathExists(["metadata", "annotations"]) with input as commondata.object_with_annotation_foo_bar
}

#-----------------------------------------------------------
# Test: inputPathExists is false when path doesnt exist on the object
#-----------------------------------------------------------
test_inputPathExists {
	not inputPathExists(["metadata", "labels"]) with input as commondata.object_with_annotation_foo_bar
}

#-----------------------------------------------------------
# Test: makePath returns concatenated path
#-----------------------------------------------------------
test_makePath {
	expected := {
		"op": "add",
		"path": "/spec/template",
		"value": {},
	}
	result := makePath(["spec", "template"])
	expected == result
}

#-----------------------------------------------------------
# Test: isPatchResponse returns if arguement has patchType and patch set
#-----------------------------------------------------------
test_makePath {
	resp_object := {
		"response": {
			"patchType": "JSONPatch",
			"patch": "/patch"
		}
	}
	isPatchResponse(resp_object)
}

#-----------------------------------------------------------
# Test: hasPatch returns true if patches has said patch
#-----------------------------------------------------------
test_hasPath {
	patches := [{
		"op": "add",
		"path": "/spec/template",
		"value": {},
	}, {
		"op": "remove",
		"path": "/spec/template",
		"value": {},
	}]

	expected_patch = {
		"op": "add",
		"path": "/spec/template",
		"value": {},
	}

	hasPatch(patches, expected_patch)
}

#-----------------------------------------------------------
# Test: isPod returns true if request.kind.kind is Pod
#-----------------------------------------------------------
test_isPod {
	isPod with input as {"request": {"kind": {"kind": "Pod"}}}
}

#-----------------------------------------------------------
# Test: isPod returns false if request.kind.kind is not Pod
#-----------------------------------------------------------
test_isNotPod {
	not isPod with input as {"request": {"kind": {"kind": "Deployment"}}}
}

#-----------------------------------------------------------
# Test: isUpdate returns true if request.operation is Update
#-----------------------------------------------------------
test_isUpdate {
	isUpdate with input as {"request": {"operation": "UPDATE"}}
}

#-----------------------------------------------------------
# Test: isCreate returns true if request.operation is Create
#-----------------------------------------------------------
test_isCreate {
	isCreate with input as {"request": {"operation": "CREATE"}}
}

#-----------------------------------------------------------
# Test: isCreateOrUpdate returns true if request.operation is Create
#-----------------------------------------------------------
test_isCreateOrUpdate_Create {
	isCreateOrUpdate with input as {"request": {"operation": "CREATE"}}
}

#-----------------------------------------------------------
# Test: isCreateOrUpdate returns true if request.operation is Update
#-----------------------------------------------------------
test_isCreateOrUpdate_Update {
	isCreateOrUpdate with input as {"request": {"operation": "UPDATE"}}
}

#-----------------------------------------------------------
# Test: The kind of main is AdmissionReview
#-----------------------------------------------------------
test_mainKind {
	main.kind == "AdmissionReview"
}

#-----------------------------------------------------------
# Test: The default response is allowed = true
#-----------------------------------------------------------
test_defaultResponse {
	response = {"allowed": true}
}

#-----------------------------------------------------------
# Test: ensureParentPathsExist
#-----------------------------------------------------------
test_ensureParentPathsExist {
	resp := ensureParentPathsExist([{
		"op": "add",
		"path": "/spec/template",
		"value": {},
	}]) with input as commondata.object_input
	expected = [{"op": "add", "path": "/spec", "value": {}}, {"op": "add", "path": "/spec/template", "value": {}}]
	resp = expected
}

#-----------------------------------------------------------
# Test: Default deny should deny with input.request.kind = "AdmissionReview"
#-----------------------------------------------------------
test_defaultDeny {
	res := main with input as {"request": {"kind": "AdmissionReview"}}
	res.response.allowed = false
}

#-----------------------------------------------------------
# Test: Default Patch should return {} if input.kine = "ThisHadBetterNotBeARealKind"
#-----------------------------------------------------------
test_defaultPatch {
	resp := main with input as {"kind":"ThisHadBetterNotBeARealKind"}
	patches = json.unmarshal(base64.decode(resp.response.patch))
	patches = [{}]
}

#-----------------------------------------------------------
# Test: isValidRequest is not value with request.kind = AdmissionReview
#-----------------------------------------------------------
test_isNotValidRequest {
	not isValidRequest with input as {"request": {"kind": "AdmissionReview"}}
}

#-----------------------------------------------------------
# Test: isValidRequest is valid with kind Pod
#-----------------------------------------------------------
test_isNotValidRequest {
	isValidRequest with input as {"request": {"kind": {"kind": "Pod"}}}
}

#-----------------------------------------------------------
# Test: Response with validation errors will not be allowed
#-----------------------------------------------------------
test_responseWithValidationErrors {
	resp := main with input as {"request": {"kind": "AdmissionReview"}}
	trace(sprintf("%s", [resp]))
	resp.response.allowed = false
}

#-----------------------------------------------------------
# Test: hasAffinity is true when the annotation has the correct value
#-----------------------------------------------------------
test_hasAffinity_true {
	hasAffinity(commondata.object_with_affinity, "example-key", "example-value")
}

#-----------------------------------------------------------
# Test: hasAffinity is false when key not correct
#-----------------------------------------------------------
test_hasAffinity_wrongKey {
	not hasAffinity(commondata.object_with_wrong_affinity, "example-key", "example-value")
}

#-----------------------------------------------------------
# Test: hasAffinity is false when value not correct
#-----------------------------------------------------------
test_hasAffinity_wrongValue {
	not hasAffinity(commondata.object_with_wrong_affinity_value, "example-key", "example-value")
}

#-----------------------------------------------------------
# Test: hasAffinity is false when there is no affinity
#-----------------------------------------------------------
test_hasAffinity_noAffinity {
	not hasAffinity(commondata.object_with_no_affinity_value, "example-key", "example-value")
}

#-----------------------------------------------------------
# Test: contains is true
#-----------------------------------------------------------
test_true_contains {
	contains(["hello", "world"], "hello")
}

#-----------------------------------------------------------
# Test: contains is false
#-----------------------------------------------------------
test_false_contains {
	not contains(["hello", "world"], "junior")
}
