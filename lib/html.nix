{ lib }:
{
  resolveHtmlAttributes =
    elem:
    let
      attributes = builtins.filter (elem: elem != "") (
        builtins.map (elem: elem._out) (builtins.attrValues elem.attributes)
      );
    in
    lib.optionalString (!builtins.isNull elem) (
      if attributes == [ ] then "" else " " + (lib.concatStringsSep " " attributes)
    );
}
