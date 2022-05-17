{ pkgs ? (import ./pkgs {}) }:

let
  lib = pkgs.lib;

  filterForDerivations = lib.mapAttrs (name: value:
    if name == "recurseForDerivations" then value
    else if lib.isDerivation value then value
    else if value.recurseForDerivations or false then filterForDerivations value
    else {}
  );
in
  lib.filterAttrsRecursive (n: v: v != {})
    (filterForDerivations (import ./release.nix { inherit pkgs; }))
