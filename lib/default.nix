args@{ lib, inputs }:

{
  module = import ./module.nix args;
  attrs = import ./attrs.nix args;
  config-maker = import ./config-maker.nix args;
}
