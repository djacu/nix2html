{ lib, config, ... }:
let
  inherit (lib) mkOption;
  inherit (lib) types;
in
{
  options = {
    a = mkOption {
      description = "The <a> tag defines a hyperlink, which is used to link from one page to another.";
      type = types.submodule (
        {
          lib,
          config,
          options,
          ...
        }:
        let

          cfg = config;
          opts = options;
        in
        {
          options = {
            attributes = mkOption {
              description = "Attributes";
              type = types.submodule {
                imports = [
                  ./download.nix
                  ./href.nix
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

          config = {
            _out =
              let
                children = "";
                attributes = (
                  lib.optionalString opts.attributes.isDefined (
                    lib.concatStringsSep " " (builtins.map (elem: elem._out) (builtins.attrValues cfg.attributes))
                  )
                );
              in
              lib.concatStringsSep "" [
                "<a "
                "${attributes}"
                ">"
                "${children}"
                "</a>"
              ];
          };
        }
      );
    };
  };

  config = {
    a = {
      children = [ ];

      attributes.download.enable = true;
      attributes.download.filename = "new-filename";

      attributes.href.enable = true;
      attributes.href.url = "#top";
    };
  };
}
