{ lib, config, ... }:
let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib) types;

  cfg = config;
in
{
  options = {
    href = mkOption {
      description = "The href attribute specifies the URL of the page the link goes to.";
      default = null;
      type = types.nullOr (
        types.submodule {
          options = {
            enable = mkEnableOption (lib.mdDoc "href");

            url = mkOption {
              description = "The URL that the link goes to.";
              type = types.nullOr types.str;
              default = null;
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
    href = {
      _out = lib.concatStringsSep "" (
        lib.optional (!builtins.isNull cfg.href && cfg.href.enable == true) (
          "href" + (lib.optionalString (!builtins.isNull cfg.href.url) "=${cfg.href.url}")
        )
      );
    };
  };
}
