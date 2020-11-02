ASSETS := $(shell yq r manifest.yaml assets.*.src)
ASSET_PATHS := $(addprefix assets/,$(ASSETS))
VERSION := $(shell toml get pastebin/Cargo.toml package.version)
PASTEBIN_SRC := $(shell find pastebin/src) pastebin/Cargo.toml pastebin/Cargo.lock $(shell find pastebin/static)
PASTEBIN_GIT_REF := $(shell cat .git/modules/pastebin/HEAD)
PASTEBIN_GIT_FILE := $(addprefix .git/modules/pastebin/,$(if $(filter ref:%,$(PASTEBIN_GIT_REF)),$(lastword $(PASTEBIN_GIT_REF)),HEAD))

.DELETE_ON_ERROR:

all: pastebin.s9pk

install: pastebin.s9pk
	appmgr install pastebin.s9pk

pastebin.s9pk: manifest.yaml config_spec.yaml config_rules.yaml image.tar instructions.md $(ASSET_PATHS)
	appmgr -vv pack $(shell pwd) -o pastebin.s9pk
	appmgr -vv verify pastebin.s9pk

image.tar: Dockerfile docker_entrypoint.sh pastebin/target/armv7-unknown-linux-gnueabihf/release/pastebin
	DOCKER_CLI_EXPERIMENTAL=enabled docker buildx build --tag start9/pastebin --platform=linux/arm/v7 -o type=docker,dest=image.tar .

pastebin/target/armv7-unknown-linux-gnueabihf/release/pastebin: $(PASTEBIN_SRC)
	docker run --rm -it -v "${HOME}/.cargo/registry":/root/.cargo/registry -v "$(shell pwd)"/pastebin:/home/rust/src start9/rust-arm-cross:latest sh -c "apt update && apt install -y llvm libclang-dev clang g++-arm-linux-gnueabihf && cargo +nightly build --release"

manifest.yaml: pastebin/Cargo.toml
	yq w -i manifest.yaml version $(VERSION)
