{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.my.alacritty;
in {
  options.my.alacritty = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    my.hm.programs.alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 0.9;
          decorations = "buttonless";
          title = "iterm2";
        };
        bell = {
          animation = "EaseOutExpo";
          duration = 5;
          color = "#ffffff";
        };
        colors = { };
        font = { size = 15; };
        selection.save_to_clipboard = true;
      };
    };
  };
}
