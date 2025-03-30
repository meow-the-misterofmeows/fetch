{
  description = "Fetch script packaged with Nix";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux"; # Adjust for your system architecture
    pkgs = import nixpkgs {
      inherit system;
      overlays = [self.overlays.default];
    };
  in {
    packages.${system}.fetch = pkgs.fetch;

    overlays.default = import ./overlay.nix;
  };
}
