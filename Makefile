DOCKER_BUILD=docker build
base:
	$(DOCKER_BUILD) -f Dockerfile -t local/hylke .
data:
	$(DOCKER_BUILD) -f data_science/Dockerfile -t local/hylke_data .
ctp:
	cd CTP; $(DOCKER_BUILD) -f Dockerfile \
		--build-arg XNAT_IP_ADDRESS=uaumcg1013.ux.umcg.intra \
		--build-arg XNAT_PROJECT_ID=nelson-test \
		-t local/ctp .
gene:
	$(DOCKER_BUILD) -f genetics/Dockerfile -t local/hylke_gene .
#all: base data
