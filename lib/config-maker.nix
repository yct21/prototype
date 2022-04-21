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
      # modules = [ inputs.home-manager.nixosModules.home-manager ] ++ modules;
      modules = [ (import path) ];
      specialArgs = { inherit lib inputs system; };
    };
}
