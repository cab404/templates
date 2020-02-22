let
    ghcVer = "ghc882";

    pin = import ./nix/sources.nix;
    pkgs = import pin.nixpkgs {};
    allhies = import pin.all-hies {};
    hie = allhies.versions.${ghcVer};
in
    pkgs.mkShell rec {
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (buildInputs);
        buildInputs = [
          hie hie.compiler
          niv pre-commit
          nixfmt
        ] ++ (with pkgs; [
            pkgconfig stack
            # Add your libraries below
        ]);
    }
