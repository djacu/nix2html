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
    attributes = mkOption {
      description = "Attributes";
      type = types.submodule { imports = builtins.map (file: paths.attributes + file) [ "/style.nix" ]; };
    };
    children = mkOption {
      description = "Children";
      type = types.listOf (
        types.attrTag (
          lib.mapAttrs' (
            path: _:
            let
              tag = lib.removeSuffix ".nix" (builtins.baseNameOf path);
            in
            lib.nameValuePair (tag) (mkOption {
              description = "<${tag}> tag";
              type = lib.types.submoduleWith {
                modules = [ (./. + ("/" + path)) ];
                specialArgs = {
                  inherit paths;
                };
              };
            })
          ) (builtins.readDir ./.)
        )
      );
    };
    _out = mkOption {
      description = "This tags output.";
      type = types.listOf types.str;
    };
  };

  config = {
    _out =
      let
        children = (
          builtins.map (elem: "  " + elem) (
            lib.flatten (builtins.map (elem: (builtins.head (builtins.attrValues elem))._out) cfg.children)
          )
        );
        attributes = htmlLib.resolveHtmlAttributes cfg;
      in
      (lib.flatten [
        "<div${attributes}>"
        children
        "</div>"
      ]);
  };
}
