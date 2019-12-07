package library.kubernetes.admission.mutate.label.test

#-----------------------------------------------------------
# Sample mutate label patch for each namespace
#-----------------------------------------------------------

patch_code_for_something = {
        "op": "add",
        "path": "/metadata/labels/something.is",
        "value": "labels"
}

#-----------------------------------------------------------
# Sample AdmissionReview to test against
#-----------------------------------------------------------

deploy_to_something = {
	"kind": "AdmissionReview",
	"request": {
		"kind": {
			"kind": "Deployment",
		},
		"resource": {
			"resource": "deployments",
		},
		"namespace": "something",
		"operation": "CREATE",
		"object": {
			"metadata": {
				"name": "deployment-without-label",
				"namespace": "something",
			},
			"spec": {
				"template": {
					"spec": {}
				},
			},
		},
	},
}

