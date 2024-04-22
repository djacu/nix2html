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
  options = {
    a = mkOption {
      description = "The <a> tag defines a hyperlink, which is used to link from one page to another.";
      default = null;
      type = types.nullOr (
        types.submodule {
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
            children = mkOption {
              description = "Children";
              type = types.listOf types.raw;
            };
            _out = mkOption {
              description = "This tags output.";
              type = types.str;
            };
          };
        }
      );
    };
  };

  config = {
    a._out =
      let
        children = "";
        attributes = htmlLib.resolveHtmlAttributes cfg.a;
      in
      lib.concatStringsSep "\n" [
        "<a${attributes}>"
        "${children}"
        "</a>"
      ];
  };
}
