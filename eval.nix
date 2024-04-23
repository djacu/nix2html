{ pkgs }:
let
  conf =
    (pkgs.lib.evalModules {
      modules = [
        ./elements/a.nix
        ./config.nix
        #(
        #  { ... }:
        #  {
        #    config._module.args = {
        #      paths = {
        #        lib = ./lib;
        #        elements = ./elements;
        #        attributes = ./attributes;
        #        modules = ./modules;
        #      };
        #    };
        #  }
        #)
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
