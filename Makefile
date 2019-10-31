PACKAGE = echo
PACKAGE_PORT = 1323
NAMESPACE = default
ME = andoshin11
ECR_ARN = 513043865727.dkr.ecr.ap-northeast-1.amazonaws.com

.PHONY: install
install:
	brew install bazel
	brew install terraform

.PHONY: clean
clean:
	bazel clean

.PHONY: gazelle
gazelle:
	bazel run gazelle
	bazel run gazelle -- update-repos -from_file ./go.mod

.PHONY: run
run:
	bazel run //packages/${PACKAGE}:${PACKAGE}

# container

.PHONY: container-login
container-login:
	$$(aws ecr get-login --no-include-email)

.PHONY: container-build
container-build:
	bazel query //... | grep "//packages/${PACKAGE}:container_image" | xargs bazel build --platforms=@io_bazel_rules_go//go/toolchain:linux_amd64

.PHONY: container-import
container-import:
	make container-build
	$(eval hash = $(shell git rev-parse HEAD | cut -c1-7))
	docker import ./bazel-bin/packages/${PACKAGE}/container_image-layer.tar ${ME}/echo-sample
	docker tag ${ME}/echo-sample ${ECR_ARN}/echo-sample:$(hash)

.PHONY: container-run
container-run:
	make container-import
	$(eval hash = $(shell git rev-parse HEAD | cut -c1-7))
	docker run -it -p ${PACKAGE_PORT}:${PACKAGE_PORT} ${ECR_ARN}:$(hash) /${PACKAGE}

.PHONY: container-push
container-push:
	make container-import
	$(eval rev = $(shell git rev-parse HEAD | cut -c1-7))
	docker push ${ECR_ARN}/echo-sample:$(rev)

# terraform

.PHONY: tf-plan
tf-plan:
	cd terraform; terraform plan

.PHONY: tf-apply
tf-apply:
	cd terraform; terraform apply

.PHONY: tf-destroy
tf-destroy:
	cd terraform; terraform destroy

.PHONY: tf-fmt
tf-fmt:
	cd terraform; terraform fmt -recursive
