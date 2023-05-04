{ pkgs }:
{
  rust = pkgs.mkShell {
    packages = with pkgs; [ rustup ];
  };
}
