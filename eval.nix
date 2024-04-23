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
    }).config;
in
#conf
pkgs.lib.concatStringsSep "\n" conf._out
