{ pkgs ? import <nixpkgs> {
overlays = [
		(self: super: {
			rustc = (super.rustc.override {
				stdenv = self.stdenv.override {
					targetPlatform = super.stdenv.targetPlatform // {
						parsed = {
							cpu = { name = "wasm32"; };
							vendor = {name = "unknown";};
							kernel = {name = "unknown";};
							abi = {name = "unknown";};
						};
					};
				};
			}).overrideAttrs (attrs: {
				configureFlags = attrs.configureFlags ++ ["--set=build.docs=false"];
			});
		})
	];
} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [ rustc cargo ];
  buildInputs = with pkgs; [ rustfmt clippy libiconv curl lld ];

  # Certain Rust tools won't work without this
  # This can also be fixed by using oxalica/rust-overlay and specifying the rust-src extension
  # See https://discourse.nixos.org/t/rust-src-not-found-and-other-misadventures-of-developing-rust-on-nixos/11570/3?u=samuela. for more details.
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  RUSTFLAGS = "-C linker=lld";

  shellHook = ''
    export PATH="~/.cargo/bin:$PATH"
  '';
}
