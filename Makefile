DOCKER_BUILD=docker build
base:
	$(DOCKER_BUILD) -f Dockerfile -t local/hylke .
data:
	$(DOCKER_BUILD) -f Dockerfile.data_science -t local/hylke_data .
ctp:
	$(DOCKER_BUILD) -f CTP/Dockerfile -t local/ctp .
#all: base data
