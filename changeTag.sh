#!/bin/bash
sed "s/tagVersion/$1/g" deploymentservice.yaml > tag.yaml
