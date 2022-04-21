{
  description = "Personal configurations for my Mac and NixOS";
  inputs = {
    # Core dependencies.
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, ... }:
    let
      lib = nixpkgs.lib.extend (final: prev: {
        my = import ./lib {
          lib = final;
          inherit inputs;
        };
      });
    in {
      pkgs = nixpkgs;
      inherit (import ./profiles { inherit lib; }) nixosConfigurations;
    };
}
