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
in
{
  imports = [ (paths.modules + "/elementChildren.nix") ];

  options = {
    attributes = mkOption {
      description = "Attributes";
      type = types.submodule {
        imports = builtins.map (file: paths.attributes + file) [
          "/download.nix"
          "/href.nix"
        ];
      };
    };

    _out = mkOption {
      description = "This tags output.";
      type = types.listOf types.str;
    };
  };

  config = {
    _out =
      let
        attributes = htmlLib.resolveHtmlAttributes cfg;
      in
      (lib.flatten [
        "<a${attributes}>"
        cfg._children
        "</a>"
      ]);
  };
}
