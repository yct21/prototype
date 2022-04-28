{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.my.zsh;
  opt = options.my.zsh;
in {
  options.my.zsh = {
    enable = mkBoolOpt false;
    env = mkOption {
      type = with types;
        attrsOf (oneOf [ str path (listOf (either str path)) ]);
      apply = mapAttrs (n: v:
        if isList v then
          concatMapStringsSep ":" (x: toString x) v
        else
          (toString v));
      default = { };
    };

    initExtra = mkOption { type = types.anything; };
    shellAliases = mkOption { type = types.anything; };
  };

  config = mkIf cfg.enable {
    my.hm.programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;

        envExtra = concatStringsSep "\n"
          (mapAttrsToList (n: v: ''export ${n}="${v}"'') cfg.env);

        initExtra = mkAliasDefinitions opt.initExtra;
        shellAliases = mkAliasDefinitions opt.shellAliases;
        history = { size = 50000; };
      };

      starship = {
        enable = true;
        enableZshIntegration = true;
        # Configuration written to ~/.config/starship.toml
        settings = { add_newline = true; };
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      htop = {
        enable = true;
        settings = {
          sort_direction = true;
          sort_key = "PERCENT_CPU";
        };
      };

      atuin = {
        enable = true;
        enableZshIntegration = true;
      };

      zoxide.enable = true;
    };

    my = {
      fzf-tab.enable = true;

      userPackages = with pkgs; [
        # modern du
        du-dust
        dua

        exa # modern ls
        fd # modern find
        croc # easily and securely transfer stuff from one computer to another
        gitui # git tui
        mask # markdown make
        ripgrep # rg
        tealdeer # tldr
        tokei # count code
      ];
    };
  };
}
