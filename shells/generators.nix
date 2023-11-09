{ pkgs }:
{
  rust = pkgs.mkShell {
    packages = with pkgs; [ rustup ];
  };

  elixir = pkgs.mkShell {
    packages = with pkgs; [ elixir ];
  };
}
