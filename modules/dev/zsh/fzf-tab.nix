{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.my.fzf-tab;
in {
  options.my.fzf-tab = { enable = mkBoolOpt false; };
  config = mkIf cfg.enable {
    my.zsh.initExtra =
      "source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh";
  };
}
