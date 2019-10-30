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
