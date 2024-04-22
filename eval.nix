{ pkgs }:
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
}).config.a._out
