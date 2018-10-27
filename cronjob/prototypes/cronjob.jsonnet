// @apiVersion 0.1
// @name work.fujioka.pkg.cronjob
// @description cronjob
// @shortDescription cronjob
// @param name string Metadata name for each of the job components
// @param image string the name of the image 
// @param script string container command array(e.g. '["sh", "-c", "echo hello"]')
// @param schedule string cron format schedule

local cronjob = import 'fuj/cronjob/cronjob.libsonnet';

local name = import 'param://name';
local image = import 'param://image';
local script = import 'param://script';
local schedule = import 'param://schedule';

cronjob.parts.cronJob(name, schedule, script, image)