FROM alpine:latest

RUN apk add --no-cache bash git docker curl nc && \
    # kubectl
    curl --location https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl --output /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    # ibmcloud cli
    curl --location https://clis.cloud.ibm.com/download/bluemix-cli/latest/linux64 | tar -xz && \
    Bluemix_CLI/install && \
    rm -rf Bluemix_CLI && \
    ibmcloud config --check-version=false && \
    ibmcloud plugin install kubernetes-service && \
    ibmcloud plugin install container-registry && \
    ibmcloud plugin install doi
