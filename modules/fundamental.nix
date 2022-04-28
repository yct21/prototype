{ config, lib, pkgs, options, ... }:

with lib;
with lib.my;
let cfg = config.my;
in {
  options.my = {
    username = mkOption { type = types.str; };
    homeDirectory = mkOption { type = types.str; };
    userPackages = mkOption { type = types.anything; };
    email = mkOption { type = types.str; };
    shell = mkOpt types.shellPackage pkgs.zsh;
  };

  config = {
    my.hm.home = {
      username = cfg.username;
      homeDirectory = cfg.homeDirectory;
      packages = mkAliasDefinitions options.my.userPackages;
    };

    users.users.${cfg.username} = {
      name = cfg.username;
      home = cfg.homeDirectory;
      shell = cfg.shell;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
}
