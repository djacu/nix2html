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
    href = mkOption {
      description = "The href attribute specifies the URL of the page the link goes to.";
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
            enable = mkEnableOption (lib.mdDoc "href");

            url = mkOption {
              description = "The URL that the link goes to.";
              type = types.str;
            };

            _out = mkOption {
              description = "This attributes output.";
              type = types.str;
            };
          };

          config = {
            _out = lib.concatStringsSep "" (
              (lib.optional cfg.enable "href") ++ (lib.optional opts.url.isDefined "=${cfg.url}")
            );
          };
        }
      );
    };
  };
}
