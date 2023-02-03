{
  description = "Nate's Nix Templates";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils }:
    {
      templates = {
        rust-dev = {
          path = ./templates/dev/rust;
          description = "Rust development environment template";
        };
      };
    }
    //
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
          generatorShells = import ./shells/generators.nix { inherit pkgs; };
      in {
        devShells = { inherit (generatorShells) rust; };
      }
    );
}
