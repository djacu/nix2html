{ lib, config, ... }:
let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib) types;

  cfg = config;
in
{
  options = {
    download = mkOption {
      description = "The download attribute specifies that the target (the file specified in the href attribute) will be downloaded when a user clicks on the hyperlink.";
      default = null;
      type = types.nullOr (
        types.submodule {
          options = {
            enable = mkEnableOption (lib.mdDoc "download");

            filename = mkOption {
              description = "Optional. Specifies the new filename for the downloaded file";
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
    download = {
      _out = (
        lib.optionalString (!builtins.isNull cfg.download && cfg.download.enable == true) (
          "download"
          + (lib.optionalString (!builtins.isNull cfg.download.filename) "=\"${cfg.download.filename}\"")
        )
      );
    };
  };
}
