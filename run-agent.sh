#!/bin/bash

docker run --rm -it --name azure-agent \
	-e AZP_URL="some azure url" \
  	-e AZP_TOKEN="some token" \
  	-e AZP_AGENT_NAME="agent smith" \
  	dockeragent:latest bash

