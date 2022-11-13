{ pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [ rustc cargo
    (with darwin.apple_sdk.frameworks; [
      Security
      CoreServices
      CoreFoundation
      Foundation
    ])
  ];
  buildInputs = with pkgs; [ rustfmt clippy libiconv curl ];

  # Certain Rust tools won't work without this
  # This can also be fixed by using oxalica/rust-overlay and specifying the rust-src extension
  # See https://discourse.nixos.org/t/rust-src-not-found-and-other-misadventures-of-developing-rust-on-nixos/11570/3?u=samuela. for more details.
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

  shellHook = ''
    export PATH="~/.cargo/bin:$PATH"
  '';
}
