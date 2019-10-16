DOCKER_BUILD=docker build
base:
	$(DOCKER_BUILD) -f Dockerfile -t local/hylke .
data:
	$(DOCKER_BUILD) -f Dockerfile.data_science -t local/hylke_data .
ctp:
	cd CTP; $(DOCKER_BUILD) -f Dockerfile \
		--build-arg XNAT_IP_ADDRESS=uaumcg1013.ux.umcg.intra \
		--build-arg XNAT_PROJECT_ID=nelson-test \
		-t local/ctp .
#all: base data
