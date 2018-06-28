{
    parts:: {
        backupjob(name, pvc, aws_access_key, aws_secret_key, bucket, directory, endpoint):: {
            "apiVersion": "batch/v1",
            "kind": "Job",
            "metadata": {
                "name": name
            },
            "spec": {
                "template": {
                    "spec": {
                        "containers": [
                            {
                                "command": [
                                    "sh",
                                    "-c",
                                    |||
                                    pip install awscli;
                                    aws --endpoint-url $ENDPOINT_URL s3 mb s3://$BUCKET;
                                    aws --endpoint-url $ENDPOINT_URL s3 sync /data s3://$BUCKET/$DIRECTORY
|||
                                ],
                                "env": [
                                    {
                                        "name": "AWS_ACCESS_KEY_ID",
                                        "value": aws_access_key
                                    },
                                    {
                                        "name": "AWS_SECRET_ACCESS_KEY",
                                        "value": aws_secret_key
                                    },
                                    {
                                        "name": "BUCKET",
                                        "value": bucket
                                    },
                                    {
                                        "name": "DIRECTORY",
                                        "value": directory
                                    }
                                ] +
                                if endpoint == null then [] else [
                                    {
                                        "name": "ENDPOINT_URL",
                                        "value": endpoint
                                    }
                                ],
                                "image": "python",
                                "name": name,
                                "volumeMounts": [
                                    {
                                        "mountPath": "/data",
                                        "name": "data",
                                        "readOnly": true
                                    }
                                ]
                            }
                        ],
                        "restartPolicy": "Never",
                        "volumes": [
                            {
                                "name": "data",
                                "persistentVolumeClaim": {
                                "claimName": pvc
                                }
                            }
                        ]
                    }
                }
            }
        }
    },
}
