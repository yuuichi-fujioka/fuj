// @apiVersion 0.1
// @name work.fujioka.pkg.cronjobWithPVC
// @description cronjob with PVC
// @shortDescription cronjob with PVC
// @param name string Metadata name for each of the job components
// @param image string the name of the image 
// @param script string container command array(e.g. '["sh", "-c", "echo hello"]')
// @param schedule string cron format schedule
// @param pvc string pvc name
// @param mountPath string mount path

local cronjob = import 'fuj/cronjob/cronjob.libsonnet';

local name = import 'param://name';
local image = import 'param://image';
local script = import 'param://script';
local schedule = import 'param://schedule';
local pvc = import 'param://pvc';
local mountPath = import 'param://mountPath';

cronjob.parts.cronJobWithPVC(name, schedule, script, image, pvc, mountPath)