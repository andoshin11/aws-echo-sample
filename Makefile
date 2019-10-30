PACKAGE = echo
NAMESPACE = default

.PHONY: install
install:
	brew install bazel

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

.PHONY: docker-run
docker-run:
	bazel run --platforms=@io_bazel_rules_go//go/toolchain:linux_amd64 //packages/${PACKAGE}:container_image

# container

.PHONY: container-build
container-build:
	bazel query //... | grep "//packages/${PACKAGE}:container_image" | xargs bazel run --platforms=@io_bazel_rules_go//go/toolchain:linux_amd64
