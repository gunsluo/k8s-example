#!/bin/bash

username=luoji
password=password
store_repo=r.xiaozhou.net
store_repo_path=r.xiaozhou.net/kubernetes

images=(gcr.io/google_containers/defaultbackend:1.4 \
    quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.17.1 \
	)

docker login -u $username -p $password $store_repo

for url in ${images[@]}
do 
    sub=${url%/*}
    idx=${#sub}
    image=${url:$idx+1}
    echo -e "upload $url -> $store_repo_path/$image"
	docker pull $url
	docker tag $url $store_repo_path/$image
	docker push $store_repo_path/$image
	docker rmi $url
	docker rmi $store_repo_path/$image
done

unset ARCH mversion nversion images username password store_repo store_repo_path
