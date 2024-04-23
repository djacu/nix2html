{ lib, config, ... }:
let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib) types;

  cfg = config;
in
{
  options = {
    class = mkOption {
      description = "The class attribute specifies one or more class names for an element.";
      default = null;
      type = types.nullOr (
        types.submodule {
          options = {
            enable = mkEnableOption (lib.mdDoc "class");

            classnames = mkOption {
              description = "Specifies one or more class names for an element.";
              type = types.listOf types.str;
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
    class = {
      _out = (
        lib.optionalString (!builtins.isNull cfg.class && cfg.class.enable == true) (
          "class=\"${lib.concatStringsSep " " cfg.class.classnames}\""
        )
      );
    };
  };
}
