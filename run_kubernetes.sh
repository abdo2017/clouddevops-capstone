#!/usr/bin/env bash

dockerpath="abdoesam2011/clouddevops"

kubectl run clouddevops --image=$dockerpath --port=80

kubectl get pods

kubectl expose deployment clouddevops --type=LoadBalancer --port=80