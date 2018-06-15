#!/bin/bash

ARCH=amd64
mversion=v1.10.4
nversion=1.14.8
username=luoji
password=password
repo=k8s.gcr.io
store_repo=r.xiaozhou.net
store_repo_path=r.xiaozhou.net/kubernetes

images=(${repo}/kube-apiserver-${ARCH}:${mversion} \
	${repo}/kube-controller-manager-${ARCH}:${mversion} \
	${repo}/kube-scheduler-${ARCH}:${mversion} \
	${repo}/kube-proxy-${ARCH}:${mversion} \
	${repo}/etcd-${ARCH}:3.1.12 \
	${repo}/pause-${ARCH}:3.1 \
	${repo}/k8s-dns-sidecar-${ARCH}:${nversion} \
	${repo}/k8s-dns-kube-dns-${ARCH}:${nversion} \
	${repo}/k8s-dns-dnsmasq-nanny-${ARCH}:${nversion} \
	${repo}/kubernetes-dashboard-${ARCH}:v1.8.3 \
    quay.io/coreos/flannel:v0.10.0-amd64 \
	)

docker login -u $username -p $password $store_repo

for url in ${images[@]}
do
    sub=${url%/*}
    idx=${#sub}
    image=${url:$idx+1}
    echo -e "download -> $store_repo_path/$image -> $url"
	docker pull $store_repo_path/$image
	docker tag $store_repo_path/$image $url
	docker rmi $store_repo_path/$image
done

unset ARCH mversion nversion images username password repo store_repo store_repo_path
