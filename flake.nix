{
  description = "Fetch script packaged with Nix";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux"; # sorry arm powered laptops and devices
    pkgs = import nixpkgs {
      inherit system;
      overlays = [self.overlays.default];
    };
  in {
    packages.${system}.fetch = pkgs.fetch;

    # Define defaultPackage explicitly
    defaultPackage.${system} = self.packages.${system}.fetch;

    overlays.default = import ./overlay.nix;
  };
}
