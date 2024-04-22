{ pkgs }:
(pkgs.lib.evalModules {
  modules = [
    ./a.nix
    #./options.nix
    #./config.nix
  ];
}).config.a._out
