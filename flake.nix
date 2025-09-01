{
  description = "dev shells";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
  outputs = { self, nixpkgs,
    rust-overlay, ...  }:
    let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [rust-overlay.overlays.default];
    };
    #TODO toolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
    toolchain = pkgs.rust-bin.nightly.latest.default;
  in {
    devShells.${system} = {
      
bevy = pkgs.mkShell {
      packages = [
        toolchain

        pkgs.rust-analyzer-unwrapped

        #rust
        pkgs.cargo
        pkgs.rustc
        # pkgs.rust-analyzer
        pkgs.rustfmt

        # If the dependencies need system libs, you usually need pkg-config + the lib
        pkgs.pkg-config
        pkgs.openssl

        # bev
        # y https:/
        # /github.com/bevyengine/bevy/blob/e67cfdf82b5726db4d449e9af31b865a5324aa19/docs/linux_dependencies.md#nix
        pkgs.udev
        pkgs.alsa-lib-with-plugins
        pkgs.vulkan-loader
        pkgs.libxkbcommon
        pkgs.wayland
        #bevy optimized
        pkgs.clang
        pkgs.mold-wrapped        
        
        #env = {
        #  RUST_BACKTRACE = "full";
        #};
            ];
            LD_LIBRARY_PATH = lib.makeLibraryParh packages;
      #TODO RUST_SRC_PATH = "${toolchain}/lib/rustlib/src/rust/library";

    };

typescript = pkgs.mkShell {
      packages = with pkgs; [
        #ts
        nodejs
        nodePackages.prettier
        nodePackages.eslint
        nodePackages.typescript-language-server
];
    };    
  };
};
}
