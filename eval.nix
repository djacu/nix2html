{ pkgs }:
let
  conf =
    (pkgs.lib.evalModules {
      modules = [
        ./elements/html.nix
        ./config.nix
      ];

      specialArgs = {
        # moved to specialArgs because _module.args was causing infinite recursion errors
        paths = {
          lib = ./lib;
          elements = ./elements;
          attributes = ./attributes;
          modules = ./modules;
        };
      };
    }).config;
in
#conf
pkgs.lib.concatStringsSep "\n" conf._out
