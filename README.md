# Wrapper for Pastebin

## Dependencies

- [docker](https://docs.docker.com/get-docker)
- [docker-buildx](https://docs.docker.com/buildx/working-with-buildx/)
- [yq](https://mikefarah.gitbook.io/yq)
- [rust-arm-builder](https://github.com/Start9Labs/rust-arm-builder)
- [appmgr](https://github.com/Start9Labs/appmgr)

## Cloning
```
git clone git@github.com:chrisguida/pastebin-wrapper.git
cd pastebin-wrapper
git submodule update --init
```

## Building

```
make
```

## Installing (on Embassy)
```
sudo appmgr install pastebin.s9pk
```
