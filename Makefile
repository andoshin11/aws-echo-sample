PACKAGE = echo
NAMESPACE = default
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

.PHONY: container-build
container-build:
	$(eval image = $(shell git rev-parse HEAD))
	bazel query //... | grep "//packages/${PACKAGE}:container_image" | xargs bazel run --platforms=@io_bazel_rules_go//go/toolchain:linux_amd64

.PHONY: container-push
container-push:
	$(eval image = $(shell git rev-parse HEAD))
	bazel query //... | grep "//packages/${PACKAGE}:container_push" | xargs bazel run --sandbox_debug --platforms=@io_bazel_rules_go//go/toolchain:linux_amd64 --host_force_python=PY2 --define IMAGE_TAG=$(image) --define ECR_ARN=${ECR_ARN}

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
