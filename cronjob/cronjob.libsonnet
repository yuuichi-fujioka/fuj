{
    parts:: {
        local base(name, schedule) = {
            "apiVersion": "batch/v1beta1",
            "kind": "CronJob",
            "metadata": {
                "name": name
            },
            "spec": {
                "concurrencyPolicy": "Forbid",
                "jobTemplate": {
                    "spec": {
                        "template": {
                            "spec": {
                                "restartPolicy": "Never"
                            }
                        }
                    }
                },
                "schedule": schedule
            }
        },
        local command(name, script, image) = {
            "spec"+: {
                "jobTemplate"+: {
                    "spec"+: {
                        "template"+: {
                            "spec"+: {
                                "containers": [
                                    {
                                        "command": script,
                                        "image": image,
                                        "name": name
                                    }  
                                ],
                            }
                        }
                    }
                }
            }
        },
        local commandWithPVC(name, script, image, pvc, mountPath) = {
            "spec"+: {
                "jobTemplate"+: {
                    "spec"+: {
                        "template"+: {
                            "spec"+: {
                                "containers": [
                                    {
                                        "command": script,
                                        "image": image,
                                        "name": name,
                                        "volumeMounts": [
                                            {
                                                "mountPath": mountPath,
                                                "name": "volume",
                                                "readOnly": false
                                            }
                                        ]
                                    }  
                                ],
                                "volumes": [
                                    {
                                        "name": "volume",
                                        "persistentVolumeClaim": {
                                            "claimName": pvc
                                        }
                                    }
                                ]
                            }
                        }
                    }
                }
            }
        },

        cronJob(name, schedule, script, image)::
            base(name, schedule) + command(name, script, image),
        cronJobWithPVC(name, schedule, script, image, pvc, mountPath)::
            base(name, schedule) + commandWithPVC(name, script, image, pvc, mountPath),
    }
}