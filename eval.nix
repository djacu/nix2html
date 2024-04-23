{ pkgs }:
let
  conf =
    (pkgs.lib.evalModules {
      modules = [
        ./elements/a.nix
        ./config.nix
        (
          { ... }:
          {
            config._module.args = {
              paths = {
                lib = ./lib;
                elements = ./elements;
                attributes = ./attributes;
              };
            };
          }
        )
      ];
    }).config._out;
in
pkgs.lib.concatStringsSep "\n" conf
