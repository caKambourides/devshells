{
  description = "dev shells";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, ...  }:
  let pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [
        nodejs
        nodePackages.prettier
        nodePackages.eslint
        nodePackages.typescript-language-server
      ];
    };

  };
}
