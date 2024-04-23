{
  lib,
  config,
  paths,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (lib) types;

  cfg = config;

  htmlLib = import (paths.lib + "/html.nix") { inherit lib; };
  modulesLib = import (paths.lib + "/modules.nix") { inherit lib; };
in
{
  options = {
    type = mkOption {
      type = types.str;
      default = "a";
    };
    attributes = mkOption {
      description = "Attributes";
      type = types.submodule {
        imports = builtins.map (file: paths.attributes + file) [
          "/download.nix"
          "/href.nix"
        ];
      };
    };
    children = mkOption {
      description = "Children";
      type = types.listOf (
        modulesLib.taggedSubmodules {
          types = {
            a = lib.types.submodule ./a.nix;
          };
          specialArgs = {
            inherit paths;
          };
        }
      );
    };
    _out = mkOption {
      description = "This tags output.";
      type = types.str;
    };
  };

  config = {
    _out =
      let
        children = lib.concatStringsSep "\n" (builtins.map (elem: elem._out) cfg.children);
        attributes = htmlLib.resolveHtmlAttributes cfg;
      in
      lib.concatStringsSep "\n" [
        "<a${attributes}>"
        "${children}"
        "</a>"
      ];
  };
}
