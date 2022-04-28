{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.my.go;
in {
  options.my.go = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    my.hm.programs.go = {
      enable = true;
      goPath = "code/go";
      goBin = ".local/bin";
    };
  };
}
