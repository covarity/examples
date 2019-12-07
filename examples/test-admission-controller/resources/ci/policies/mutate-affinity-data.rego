package library.kubernetes.admission.mutate.affinty.test

#-----------------------------------------------------------
# Sample patch values to test against
#-----------------------------------------------------------

patchCode_noAffinity_operation_tools = {
        "op": "add",
        "path": "/spec/template/spec/affinity",
        "value": {
            "nodeAffinity": {
                "requiredDuringSchedulingIgnoredDuringExecution": {
                    "nodeSelectorTerms": [{
                        "matchExpressions": [{
                            "key": "anchor.trussio/function",
                            "operator": "In",
                            "values": ["operation-tools"]
                        }]
                    }]
                }
            }
        }
    }

patchCode_nodeAffinity_operation_tools = {
	"op": "add",
	"path": "/spec/template/spec/affinity/nodeAffinity/requiredDuringSchedulingIgnoredDuringExecution",
	"value": {
        "nodeSelectorTerms": [
        {
            "matchExpressions": [
            {
                "key": "anchor.trussio/function",
                "operator": "In",
                "values": ["operation-tools"]
            }
            ]
        }
        ]
    }
}

patchCode_matchExpression_operation_tools = {
	"op": "add",
	"path": "/spec/template/spec/affinity/nodeAffinity/requiredDuringSchedulingIgnoredDuringExecution/nodeSelectorTerms/0/matchExpressions",
	"value": [{
		"key": "anchor.trussio/function",
		"operator": "In",
		"values": ["operation-tools"]
	}]
}

#-----------------------------------------------------------
# Sample AdmissionReview to test against
#-----------------------------------------------------------

no_matchExpression_istio_system = {
	"kind": "AdmissionReview",
	"request": {
		"kind": {
			"kind": "Deployment",
		},
		"resource": {
			"resource": "deployments",
		},
		"namespace": "istio-system",
		"operation": "CREATE",
		"object": {
			"metadata": {
				"name": "deployment-demo-bad-no-version",
				"namespace": "istio-system",
			},
			"spec": {
				"template": {
					"spec": {
						"affinity": {
							"nodeAffinity": {
								"requiredDuringSchedulingIgnoredDuringExecution": {
									"nodeSelectorTerms" : [{
										"matchExpressions":  [{
											"key": "example-key",
											"operator": "In",
											"values": ["example-value"]
										}]
									}]
								}
							}
						}
					},
				},
			},
		},
	},
}

no_nodeAffinity_istio_system = {
	"kind": "AdmissionReview",
	"request": {
		"kind": {
			"kind": "Deployment",
		},
		"resource": {
			"resource": "deployments",
		},
		"namespace": "istio-system",
		"operation": "CREATE",
		"object": {
			"metadata": {
				"name": "deployment-demo-bad-no-version",
				"namespace": "istio-system",
			},
			"spec": {
				"template": {
					"spec": {
						"affinity": {
							"nodeAffinity": {
							}
						}
					},
				},
			},
		},
	},
}

no_affinity_istio_system = {
	"kind": "AdmissionReview",
	"request": {
		"kind": {
			"kind": "Deployment",
		},
		"resource": {
			"resource": "deployments",
		},
		"namespace": "istio-system",
		"operation": "CREATE",
		"object": {
			"metadata": {
				"name": "deployment-demo-bad-no-version",
				"namespace": "istio-system",
			},
			"spec": {
				"template": {
					"spec": {}
				},
			},
		},
	},
}

#-----------------------------------------------------------
# Sample AdmissionReview to test against
#-----------------------------------------------------------

no_matchExpression_ops = {
	"kind": "AdmissionReview",
	"request": {
		"kind": {
			"kind": "Deployment",
		},
		"resource": {
			"resource": "deployments",
		},
		"namespace": "ops",
		"operation": "CREATE",
		"object": {
			"metadata": {
				"name": "deployment-demo-bad-no-version",
				"namespace": "ops",
			},
			"spec": {
				"template": {
					"spec": {
						"affinity": {
							"nodeAffinity": {
								"requiredDuringSchedulingIgnoredDuringExecution": {
									"nodeSelectorTerms" : [{
										"matchExpressions":  [{
											"key": "example-key",
											"operator": "In",
											"values": ["example-value"]
										}]
									}]
								}
							}
						}
					},
				},
			},
		},
	},
}

no_nodeAffinity_ops = {
	"kind": "AdmissionReview",
	"request": {
		"kind": {
			"kind": "Deployment",
		},
		"resource": {
			"resource": "deployments",
		},
		"namespace": "ops",
		"operation": "CREATE",
		"object": {
			"metadata": {
				"name": "deployment-demo-bad-no-version",
				"namespace": "ops",
			},
			"spec": {
				"template": {
					"spec": {
						"affinity": {
							"nodeAffinity": {
							}
						}
					},
				},
			},
		},
	},
}

no_affinity_ops = {
	"kind": "AdmissionReview",
	"request": {
		"kind": {
			"kind": "Deployment",
		},
		"resource": {
			"resource": "deployments",
		},
		"namespace": "ops",
		"operation": "CREATE",
		"object": {
			"metadata": {
				"name": "deployment-demo-bad-no-version",
				"namespace": "ops",
			},
			"spec": {
				"template": {
					"spec": {}
				},
			},
		},
	},
}

