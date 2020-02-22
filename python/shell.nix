let
  pin = import ./nix/sources.nix;
  pkgs = import pin.nixpkgs {};
in
pkgs.mkShell {
  buildInputs =
    with pkgs;
    with python3Packages; [

    # Dev dependencies
    black rope
    poetry pylint
    pre-commit
    nixfmt

  ] ++ (if (builtins.pathExists ./poetry.lock) then
    [
      (poetry2nix.mkPoetryEnv {
        poetrylock = ./poetry.lock;
        pyproject = ./pyproject.toml;
        })
    ]
  else
    []
  );

  shellHook = "pre-commit install";
}
