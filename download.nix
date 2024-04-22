{
  lib,
  options,
  config,
  ...
}:
let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib) types;
in
{
  options = {
    download = mkOption {
      description = "The download attribute specifies that the target (the file specified in the href attribute) will be downloaded when a user clicks on the hyperlink.";
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
            enable = mkEnableOption (lib.mdDoc "download");

            filename = mkOption {
              description = "Optional. Specifies the new filename for the downloaded file";
              type = types.str;
            };

            _out = mkOption {
              description = "This attributes output.";
              type = types.str;
            };
          };

          config = {
            _out = lib.concatStringsSep "" (
              (lib.optional cfg.enable "download") ++ (lib.optional opts.filename.isDefined "=${cfg.filename}")
            );
          };
        }
      );
    };
  };
}
