#!/bin/sh

ARCH=amd64
mversion=v1.10.4
nversion=1.14.8
username=luoji
password=password
store_repo=r.xiaozhou.net
store_repo_path=r.xiaozhou.net/kubernetes
 
images=(kube-apiserver-${ARCH}:${mversion} \
	kube-controller-manager-${ARCH}:${mversion} \
	kube-scheduler-${ARCH}:${mversion} \
	kube-proxy-${ARCH}:${mversion} \
	etcd-${ARCH}:3.1.12 \
	pause-${ARCH}:3.1 \
	k8s-dns-sidecar-${ARCH}:${nversion} \
	k8s-dns-kube-dns-${ARCH}:${nversion} \
	k8s-dns-dnsmasq-nanny-${ARCH}:${nversion} \
	)
 
docker login -u $username -p $password $store_repo
 
for image in ${images[@]}
do
    echo download/upload k8s.gcr.io/${image}
	docker pull k8s.gcr.io/${image}
	docker tag k8s.gcr.io/${image} ${store_repo_path}/${image}
	docker push ${store_repo_path}/${image}
	docker rmi k8s.gcr.io/${image}
	docker rmi ${store_repo_path}/${image}
done

docker pull quay.io/coreos/flannel:v0.10.0-amd64
docker tag quay.io/coreos/flannel:v0.10.0-amd64 ${store_repo_path}/flannel:v0.10.0-amd64
docker push ${store_repo_path}/flannel:v0.10.0-amd64
docker rmi quay.io/coreos/flannel:v0.10.0-amd64
docker rmi ${store_repo_path}/flannel:v0.10.0-amd64
 
unset ARCH mversion nversion images username password store_repo store_repo_path
