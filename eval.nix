{ pkgs }:
(pkgs.lib.evalModules {
  modules = [
    ./a.nix
    ./config.nix
  ];
}).config.a._out
