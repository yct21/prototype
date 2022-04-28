# base configuration for remote develop machine
#
# - nixos
# - compiling things
# - no desktop

{ config, lib, pkgs, ... }:

{
  time.timeZone = "Asia/Shanghai";

  my = {
    username = "yct21";
    email = "yct21@12tcy.com";
    homeDirectory = "/home/yct21";
    userPackages = with pkgs; [ act docker bore-cli screen k3s dig ];
    zsh = {
      enable = true;
      env.EDITOR = "vim";
    };
    go.enable = true;
    git.enable = true;

    hm = { programs.home-manager.enable = true; };
  };

  networking = {
    defaultGateway = "192.168.31.2";
    nameservers = [ "192.168.31.2" ];
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 80 ];
  };

  environment.systemPackages = with pkgs; [ vim wget git ];

  services.openssh.enable = true;

  nix = {
    # package = pkgs.nixFlakes; # or versioned attributes like nix_2_7
    binaryCaches =
      [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
