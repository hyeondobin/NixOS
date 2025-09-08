{
  description = "Dobin NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      systems = ["x86_64-linux"];
      # forAllsystems = nixpkgs.lib.genAttrs system;
      username = "dobin";
      
      in
    {
    nixosConfigurations = {
      VanLioumLT = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/VanLioumLT/configuration.nix
	        home-manager.nixosModules.home-manager
	        {
	          home-manager.useGlobalPkgs = true;
	          home-manager.useUserPackages = true;
	          home-manager.users.dobin = import ./home;
            home-manager.backupFileExtension = "home-manager-backup";
	        }
        ];
      };
    };
  };
}
