{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.my.git;
  inherit (config.my) username email;
in {
  options.my.git = {
    enable = mkBoolOpt false;
    ignores = mkOpt (types.listOf types.str) [ "scratch.org" ];
  };

  config = mkIf cfg.enable {
    my.hm.programs.git = {
      enable = true;
      userName = username;
      userEmail = email;
      ignores = cfg.ignores;
      extraConfig = {
        # url."https://gitclone.com/".insteadOf = "https://github.com/";
        init.defaultBranch = "main";
      };
    };
  };
}
