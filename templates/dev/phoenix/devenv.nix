{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [ pkgs.yarn ];

  # https://devenv.sh/scripts/
  scripts = {
    setup.exec = ''
      git init
      mix local.hex
      mix archive.install hex phx_new
      mix phx.new .
      initdb
      start-postgres &
      until pg_isready; do sleep 1; done
      createuser -s postgres
      mix setup
      pg_ctl stop
      echo ".devenv" >> .gitignore
      echo ".dirnv" >> .gitignore
      git add .
      git commit -am "Initial commit"
    '';
  };

  enterShell = ''
    export PATH="$HOME/.mix/escripts:$PATH"
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep "2.42.0"
  '';

  # https://devenv.sh/services/
  services = {
    postgres = {
      enable = true;

      initialScript = ''
        create role postgres with superuser login;
      '';
    };
  };

  # https://devenv.sh/languages/
  languages = {
    elixir = { enable = true; };
    javascript = { enable = true; };
  };

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # https://devenv.sh/processes/
  processes = { phoenix.exec = "mix phx.server"; };

  # See full reference at https://devenv.sh/reference/options/
}
