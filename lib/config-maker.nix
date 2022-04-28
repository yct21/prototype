{ inputs, lib, ... }:

let
  inherit (lib) nixosSystem mkDefault removeSuffix;
  inherit (inputs.darwin.lib) darwinSystem;
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
  makeNixOsConfig = path:
    { system ? "x86_64-linux", pkgs ? inputs.nixpkgs }:
    nixosSystem {
      inherit system;
      modules = [
        ../base
        inputs.home-manager.nixosModules.home-manager
        {
          # nixpkgs.pkgs = pkgs;
          networking.hostName =
            mkDefault (removeSuffix ".nix" (baseNameOf path));
        }
        (import path)
      ];
      specialArgs = { inherit lib inputs system; };
    };
}
