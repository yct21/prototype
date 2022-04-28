{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ../../base/remote-dev.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "21.11";
  networking.interfaces.enp42s0.useDHCP = true;
  networking.interfaces.wlp41s0 = {
    useDHCP = false;
    ipv4.addresses = [{
      address = "192.168.31.72";
      prefixLength = 24;
    }];
  };

  virtualisation.docker.enable = true;

  # k3s
  networking.firewall.allowedTCPPorts = [ 6443 8080 ];
  services.k3s.enable = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  ];
}
