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

  mergeChildren =
    children: builtins.map (child: (builtins.head (builtins.attrValues child))._out) children;
  indentChildren = children: builtins.map (child: "  " + child) (lib.flatten children);
in
{
  options = {
    children = mkOption {
      description = "Children";
      type = types.listOf (
        types.attrTag (
          lib.mapAttrs' (
            path: filetype:
            let
              tag = lib.removeSuffix ".nix" (builtins.baseNameOf path);
            in
            lib.nameValuePair (tag) (mkOption {
              description = "<${tag}> tag";
              type = lib.types.submoduleWith {
                modules = [ (paths.elements + ("/" + path)) ];
                specialArgs = {
                  inherit paths;
                };
              };
            })
          ) (builtins.readDir paths.elements)
        )
      );
    };

    _children = mkOption { type = types.listOf types.str; };
  };

  config = {
    _children = indentChildren (mergeChildren cfg.children);
  };
}
