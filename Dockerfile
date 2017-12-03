FROM microsoft/aspnetcore-build:2.0

# Pin Kubernetes Kubectl v1.8.4 
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.8.4/bin/linux/amd64/kubectl && \
	chmod +x ./kubectl && \
	mv ./kubectl /bin/kubectl #/usr/local/bin/kubectl
	
RUN	apt-get update && \
	apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

#Pin Docker CE to 17.09.0~ce-0~debian
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - && \
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" && \
	apt-get update && \
	apt-get install -y docker-ce=17.09.0~ce-0~debian && \
	rm -rf /var/lib/apt/lists/*
WORKDIR /app
#apt-cache madison docker-ce to list docker versions available
#Config Kubectl is up to you
#kubectl config set-cluster <my.cluster.name> --server=<my.kubernetes.host>
#kubectl config set-credentials <my.user> --username=$KUBERNETES_USERNAME --password=$KUBERNETES_PASSWORD
#kubectl config set-context <my.context> --cluster=<my.cluster.name> --user=<my.user>
#kubectl config use-context <my.context>
#Update the deployment to use the new Docker image
#kubectl set image deployment/<my.app> <my.app>=<my.dockerhub.username>/<my.app>:$BITBUCKET_COMMIT

#DEBUGGING USAGE 
# mount your outer volume context '.' to /app folder in the container
#docker run -it -v ${PWD}:/app relicx74/aspnetcore-build-kube bash
