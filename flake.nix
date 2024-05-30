{
  description = "Nate's Nix Templates";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    {
      templates = {
        elixir-dev = {
          path = ./templates/dev/elixir;
          description = "Elixir development environment template";
        };
        haskell-dev = {
          path = ./templates/dev/haskell;
          description = "Haskell development environment template";
        };
        phoenix-dev = {
          path = ./templates/dev/phoenix;
          description = "From scratch pheonix framework template";
        };
        roc-dev = {
          path = ./templates/dev/roc;
          description = "Roc development environment template";
        };
        rust-dev = {
          path = ./templates/dev/rust;
          description = "Rust development environment template";
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        generatorShells = import ./shells/generators.nix { inherit pkgs; };
      in
      {
        devShells = {
          inherit (generatorShells) rust elixir;
        };
      }
    );
}
