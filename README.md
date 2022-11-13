# Zoop

## Getting started

Build `trunk` and `wasm-bindgen-cli`

```shell
nix-shell native-shell.nix
cargo install --locked trunk
cargo install wasm-bindgen-cli
```

## Run the project

```shell
nix-shell
trunk serve
```

## Signing commit

```
nix-shell -p gnupg
```
