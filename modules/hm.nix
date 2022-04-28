# home-manager wrapper

{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.my.hm;
in {
  options.my.hm = mkOption { type = types.anything; };

  config = {
    home-manager = {
      users.${config.my.username} = mkAliasDefinitions options.my.hm;
    };
  };
}
