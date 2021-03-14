#grafana admin/grafana

#demarre minikube
#docker service start
#sudo chmod 777 /var/run/docker.sock
minikube start --driver=docker
eval $(minikube docker-env)
minikube addons enable dashboard
minikube addons enable metrics-server
minikube addons enable metallb
sleep 20

#reglage ip (pbs possibles avec vm)
new_ip=$(kubectl get nodes -o wide | grep minikube | cut -d " " -f 17)
find $(pwd)/srcs -type f -exec \
            sed -i 's/192.168.49.2/'"$new_ip"'/g' {} +
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system

#install metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

#apply conf globale
kubectl apply -f ./srcs/config.yaml

#montage des images docker

docker build -t image-phpmyadmin ./srcs/php-my-admin/
docker build -t image-mysql ./srcs/mysql/
docker build -t image-wordpress ./srcs/Wordpress/
docker build -t image-influxdb ./srcs/influxdb/
docker build -t image-grafana ./srcs/grafana/
#docker build -t image-grafana ./srcs/grafana_claire/
docker build -t image-nginx ./srcs/nginx/
#docker build -t image-nginx ./srcs/nginx_claire/

docker build -t image-ftps ./srcs/FTPS/
#docker build -t image-ftps ./srcs/FTPS_claire/

#application des configs sur les images
kubectl apply -f ./srcs/php-my-admin/php.yaml
kubectl apply -f ./srcs/influxdb/influxdb.yaml
kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/Wordpress/wordpress.yaml
kubectl apply -f ./srcs/grafana/grafana.yaml
#kubectl apply -f ./srcs/grafana_claire/grafana.yaml
kubectl apply -f ./srcs/nginx/nginx.yaml
#kubectl apply -f ./srcs/nginx_claire/nginx.yaml

kubectl apply -f ./srcs/FTPS/ftps.yaml
#kubectl apply -f ./srcs/FTPS_claire/ftps.yaml

#lancer le dashboard minikube
minikube dashboard