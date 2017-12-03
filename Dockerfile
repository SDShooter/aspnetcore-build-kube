FROM microsoft/aspnetcore-build:2.0

# Pin Kubernetes Kubectl v1.8.4 
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.8.4/bin/linux/amd64/kubectl && \
	chmod +x ./kubectl && \
	mv ./kubectl /bin/kubectl #/usr/local/bin/kubectl 
WORKDIR /APP
#Config Kubectl is up to you
#kubectl config set-cluster <my.cluster.name> --server=<my.kubernetes.host>
#kubectl config set-credentials <my.user> --username=$KUBERNETES_USERNAME --password=$KUBERNETES_PASSWORD
#kubectl config set-context <my.context> --cluster=<my.cluster.name> --user=<my.user>
#kubectl config use-context <my.context>
#Update the deployment to use the new Docker image
#kubectl set image deployment/<my.app> <my.app>=<my.dockerhub.username>/<my.app>:$BITBUCKET_COMMIT
#