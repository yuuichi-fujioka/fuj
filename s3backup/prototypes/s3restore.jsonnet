// @apiVersion 0.1
// @name work.fujioka.pkg.s3restore
// @description restore pvc from s3 or s3 compatible object storage
// @shortDescription restore job
// @param name string Metadata name for each of the job components
// @param pvc string the name of the PersistentVolumeClaim 
// @param aws_access_key string aws access key
// @param aws_secret_key string aws access secret key
// @param bucket string bucket name(e.g. backups)
// @param directory string directory name(e.g. foo/bar/baz)
// @optionalParam endpoint string null endpoint url. if this is null, this job restore pvc from s3

local k = import 'k.libsonnet';
local s3backup = import 'fuj/s3backup/s3backup.libsonnet';

local appName = import 'param://name';
local pvc = import 'param://pvc';
local aws_access_key = import 'param://aws_access_key';
local aws_secret_key = import 'param://aws_secret_key';
local bucket = import 'param://bucket';
local directory = import 'param://directory';
local endpoint = import 'param://endpoint';

s3backup.parts.restorejob(
    appName, pvc, aws_access_key, aws_secret_key, bucket, directory, endpoint
)
