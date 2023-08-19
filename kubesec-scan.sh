#!/bin/bash

scan_result=$(curl -sSX POST --data-binary @"trackerapp-k8s-manifests/base-manifests/UserMgmtWebApp-Deployment.yaml" https://v2.kubesec.io/scan)
scan_message=$(curl -sSX POST --data-binary @"trackerapp-k8s-manifests/base-manifests/UserMgmtWebApp-Deployment.yaml" https://v2.kubesec.io/scan | jq .[0].message -r )
scan_score=$(curl -sSX POST --data-binary @"trackerapp-k8s-manifests/base-manifests/UserMgmtWebApp-Deployment.yaml" https://v2.kubesec.io/scan | jq .[0].score )

echo "Results for UserMgmtWebApp-Deployment.yaml file"
echo "#######################################"
echo "Scan Result is $scan_result"
echo "Scan Message is $scan_message"

if [ "${scan_score}" -ge 5 ]; then
    echo "Score is $scan_score"
    echo "Kubesec Scan $scan_message"
else
    echo "Score is $scan_score, which is less than or equal to 5."
    echo "Scanning Kubernetes Resource has Failed"
    exit 1
fi

scan_result=$(curl -sSX POST --data-binary @"trackerapp-k8s-manifests/base-manifests/mysql-deployment.yaml" https://v2.kubesec.io/scan)
scan_message=$(curl -sSX POST --data-binary @"trackerapp-k8s-manifests/base-manifests/mysql-deployment.yaml" https://v2.kubesec.io/scan | jq .[0].message -r )
scan_score=$(curl -sSX POST --data-binary @"trackerapp-k8s-manifests/base-manifests/mysql-deployment.yaml" https://v2.kubesec.io/scan | jq .[0].score )

echo "Results for mysql-deployment.yaml file"
echo "#######################################"
echo "Scan Result is $scan_result"
echo "Scan Message is $scan_message"

if [ "${scan_score}" -ge 5 ]; then
    echo "Score is $scan_score"
    echo "Kubesec Scan $scan_message"
else
    echo "Score is $scan_score, which is less than or equal to 5."
    echo "Scanning Kubernetes Resource has Failed"
    exit 1
fi
