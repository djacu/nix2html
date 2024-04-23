{ lib, config, ... }:
let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib) types;

  cfg = config;
in
{
  options = {
    contenteditable = mkOption {
      description = "The style attribute specifies an inline style for an element.";
      default = null;
      type = types.nullOr (
        types.submodule {
          options = {
            enable = mkEnableOption (lib.mdDoc "contenteditable");

            value = mkOption {
              description = "One or more CSS properties and values separated by semicolons.";
              type = types.bool;
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
    contenteditable = {
      _out = (
        lib.optionalString (!builtins.isNull cfg.contenteditable && cfg.contenteditable.enable == true) (
          "contenteditable=\"${lib.boolToString cfg.contenteditable.value}\""
        )
      );
    };
  };
}
