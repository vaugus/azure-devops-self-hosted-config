FROM debian:stable-slim

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    git \
    iputils-ping \
    jq \
    lsb-release \
    software-properties-common

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64

WORKDIR /azp

COPY ./install-azure-dependencies.sh .
RUN chmod +x install-azure-dependencies.sh \
    && DEBIAN_FRONTEND=noninteractive ./install-azure-dependencies.sh

COPY ./start.sh .
RUN chmod +x start.sh

RUN adduser --disabled-password --gecos "" agent
RUN chown -R agent:agent /azp
USER agent

ENTRYPOINT [ "./start.sh" ]
