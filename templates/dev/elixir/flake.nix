{
  description = "Basic Rust development environment";

  inputs = { flake-utils.url = "github:numtide/flake-utils"; };

  outputs = { self, nixpkgs, flake-utils }:
    let overlays = [ ];
    in flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit overlays system; };
      in {
        devShells.default = pkgs.mkShell {
          packages = (with pkgs; [ elixir_1_15 erlang_26 ])
            ++ pkgs.lib.optionals pkgs.stdenv.isDarwin (with pkgs; [
              libclang
              libiconv
              darwin.apple_sdk.frameworks.Security
              darwin.apple_sdk.frameworks.CoreServices
              darwin.apple_sdk.frameworks.Carbon
            ]);
        };
      });
}
