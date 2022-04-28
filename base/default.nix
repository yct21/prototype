# default setting

{ inputs, config, lib, pkgs, ... }:

with lib;
with lib.my; {
  imports = mapModulesRec' (toString ../modules) import;

  config = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  };
}
