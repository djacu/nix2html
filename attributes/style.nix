{ lib, config, ... }:
let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib) types;

  cfg = config;
in
{
  options = {
    style = mkOption {
      description = "The style attribute specifies an inline style for an element.";
      default = null;
      type = types.nullOr (
        types.submodule {
          options = {
            enable = mkEnableOption (lib.mdDoc "style");

            definitions = mkOption {
              description = "One or more CSS properties and values separated by semicolons.";
              type = types.nullOr types.str;
            };

            _out = mkOption {
              description = "This attributes output.";
              type = types.str;
            };
          };
        }
      );
    };
  };

  config = {
    style = {
      _out = (
        lib.optionalString (!builtins.isNull cfg.style && cfg.style.enable == true) (
          "style=\"${cfg.style.definitions}\""
        )
      );
    };
  };
}
