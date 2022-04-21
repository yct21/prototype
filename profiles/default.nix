{ lib }:

let inherit (lib.my.config-maker) makeNixOsConfig;

in { nixosConfigurations = { albatrox = makeNixOsConfig ./albatrox { }; }; }
