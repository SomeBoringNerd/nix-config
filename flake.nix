{
  description = "NixOS configuration";

  inputs = 
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs 
    {
      inherit system;
      config.allowUnfree = true;
    };

    lib = nixpkgs.lib;

  in 
  {
    nixosConfigurations = 
    {
      MAIN = lib.nixosSystem 
      {
        inherit system;
        modules = 
        [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.someboringnerd = import ./home/home.nix;
          }
        ];
      };
    };
  };
}
