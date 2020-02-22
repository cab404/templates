{
  description = "My template set for various languages";

  outputs = { self, nixpkgs }:

    let
      lib = import lib;
      buildTemplate = { linkme, caches }: {};
      toTemplateOutput = path: with builtins; {
        "${baseNameOf path}" = {
          inherit path;
          description = "A template";
        };
      };
      upd = a: b: a // b;
      templateFolders = [
        ./haskell
        ./python
	      ./rust
      ];
    in {
      templates = builtins.foldl' upd {} (map toTemplateOutput templateFolders);
    };
}
