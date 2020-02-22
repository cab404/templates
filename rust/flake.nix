let
  packageName = "hello";
  packageVersion = "0.1.0";
  packageDescription = "CHANGEME";
in
{

  description = packageDescription;

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {

        defaultPackage = with pkgs;
          rustPlatform.buildRustPackage {
            pname = packageName;
            version = packageVersion;
            src = ./.;
            cargoSha256 = "0gdpfzs62hph65yzbf8mm0xfmvihsprigz7jq4jfxh08yf0w7s1i";
          };

        defaultApp = {
          type = "app";
          program = "${self.defaultPackage."${system}"}/bin/wgbond";
        };

      });
}
