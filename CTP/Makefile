DOCKER_BUILD=docker build
x11:
	$(DOCKER_BUILD) -f Dockerfile.x11 \
		--build-arg XNAT_IP_ADDRESS=uaumcg1013.ux.umcg.intra \
		--build-arg XNAT_PROJECT_ID=nelson-test \
		-t local/ctp.x11 .
minimal:
	$(DOCKER_BUILD) -f Dockerfile \
		--build-arg XNAT_IP_ADDRESS=uaumcg1013.ux.umcg.intra \
		--build-arg XNAT_PROJECT_ID=nelson-test \
		-t local/ctp .
all: minimal x11
