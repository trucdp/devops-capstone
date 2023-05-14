## The Makefile includes instructions on: 
# environment setup, install, lint and build

#Vars
CLUSTER_NAME=udacity-dev-eks
REGION_NAME=us-east-1
KEYPAIR_NAME=eks-terraform-key
DEPLOYMENT_NAME=app
NEW_IMAGE_NAME=registry.hub.docker.com/trucdp/app:latest
CONTAINER_PORT=80
HOST_PORT=8080
KUBECTL=kubectl

setup:
	# Create a python virtualenv & activate it
	python3 -m venv ~/.devops-capstone
	# source ~/.devops-capstone/scripts/activate 

install:	# TODO: Add a Docker analysis (DevSecOps)
	# This should be run from inside a virtualenv
	echo "Installing: dependencies..."
	pip install --upgrade pip &&\
	pip install -r app/requirements.txt
	# pip install "ansible-lint[community,yamllint]"
	echo
	pytest --version
	# ansible --version
	# ansible-lint --version
	echo
	echo "Installing: shellcheck"
	./scripts/install_shellcheck.sh
	echo
	echo "Installing: hadolint"
	./scripts/install_hadolint.sh
	echo
	echo "Installing: kubectl"
	./scripts/install_kubectl.sh
	echo
test:
	# Additional, optional, tests could go here
	#python -m pytest -vv app/app.py
	#python -m pytest 

lint:
	# https://github.com/koalaman/shellcheck: a linter for shell scripts
	./scripts/shellcheck -Cauto -a ./scripts/*.sh
	# https://github.com/hadolint/hadolint: a linter for Dockerfiles
	./scripts/hadolint app/Dockerfile
	# https://www.pylint.org/: a linter for Python source code 
	# This should be run from inside a virtualenv
	pylint --output-format=colorized --disable=C app/app.py

run-app:
	python3 app/app.py

build-docker:
	./scripts/build_docker.sh

run-docker: build-docker
	./scripts/run_docker.sh

upload-docker: build-docker
	./scripts/upload_docker.sh

ci-validate:
	# Required file: .circleci/config.yml
	circleci config validate

k8s-deployment: eks-create-cluster
	./scripts/k8s_deployment.sh

port-forwarding: 
	# Needed for "minikube" only
	${KUBECTL} port-forward service/${DEPLOYMENT_NAME} ${HOST_PORT}:${CONTAINER_PORT}

rolling-update:
	${KUBECTL} get deployments -o wide
	${KUBECTL} set image deployments/${DEPLOYMENT_NAME} \
		${DEPLOYMENT_NAME}=${NEW_IMAGE_NAME}
	echo
	${KUBECTL} get deployments -o wide
	${KUBECTL} describe pods | grep -i image
	${KUBECTL} get pods -o wide

rollout-status:
	${KUBECTL} rollout status deployment ${DEPLOYMENT_NAME}
	echo
	${KUBECTL} get deployments -o wide

rollback:
	${KUBECTL} get deployments -o wide
	${KUBECTL} rollout undo deployment ${DEPLOYMENT_NAME}
	${KUBECTL} describe pods | grep -i image
	echo
	${KUBECTL} get pods -o wide
	${KUBECTL} get deployments -o wide

k8s-cleanup-resources:
	./scripts/k8s_cleanup_resources.sh

eks-create-cluster:
	./scripts/deploy-infra.sh

eks-delete-cluster:
	./scripts/deploy-infra.sh	