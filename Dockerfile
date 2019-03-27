FROM alpine:latest

RUN apk add --update netcat-openbsd && rm -rf /var/cache/apk/*

RUN apk add --no-cache bash git docker curl
 
    # kubectl
RUN curl --location https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl --output /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    # ibmcloud cli
    curl --location https://clis.cloud.ibm.com/download/bluemix-cli/latest/linux64 | tar -xz && \
    Bluemix_CLI/install && \
    rm -rf Bluemix_CLI && \
    ibmcloud config --check-version=false && \
    ibmcloud plugin install kubernetes-service && \
    ibmcloud plugin install container-registry && \
    # to be consistent with default pipeline-worker base image
    ibmcloud plugin install doi -f -v 0.0.6
