{ lib }:
{
  /*
    A type that is one of several submodules, similiar to types.oneOf, but can be used with multiple attrset-like types (e.g. `attrs`, `attrsOf`, `submodule`).
    Submodules need an option called `type` that is of type `types.str`. It is used to find the correct type during `check` and `merge`.
    Unlike `types.oneOf`, this type takes an attrset argument. Pass the submodules as an attrset to the `types` key in the function argument.
    The function argument has a `specialArgs` key that passes additional argument to the submodules via `_module.args`.

    This type can also be used inside `types.attrsOf` or `types.listOf`

    A shout out to the disko team for initially creating this and @Lassulus for submitting a concise PR with examples to nixpkgs.
    https://github.com/nix-community/disko/
    https://github.com/NixOS/nixpkgs/pull/254790
  */
  taggedSubmodules =
    {
      types,
      specialArgs ? { },
    }:
    lib.mkOptionType {
      name = "taggedSubmodules";
      description = "One of ${lib.concatStringsSep "," (builtins.attrNames types)}";
      check =
        x:
        if x ? type then
          types.${x.type}.check x
        else
          throw "No type option set in:\n${lib.generators.toPretty { } x}";
      merge =
        loc:
        lib.foldl' (
          res: def:
          types.${def.value.type}.merge loc [
            (lib.recursiveUpdate { value._module.args = specialArgs; } def)
          ]
        ) { };
      nestedTypes = types;
    };
}
