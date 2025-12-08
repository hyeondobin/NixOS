{
  description = "Dobin NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

  };
  outputs =
    {
      nixpkgs,
      home-manager,
      catppuccin,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        VanLioumLaptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/VanLioumLaptop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.hyeondobin = {
                  imports = [
                    ./home
                    catppuccin.homeModules.catppuccin
                  ];
                };
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
              };
            }
          ];
        };
        # VanLioumDesktop = nixpkgs.lib.nixosSystem {
        #     system = "x86_64-linux";
        #     specialArgs = {inherit inputs; };
        #     modules = [
        #         ./hosts/VanLioumDesktop/configuration.nix
        #         home-manager.nixosModules.hime-manager
        #         {
        #             home-manager = {
        #                 useGlobalPkgs = true;
        #                 usoUserPackages = true;
        #                 users.hyeondobin = import ./home;
        #                 backupFileExtension = "home-manager-backup";
        #             };
        #         };
        #     ];
        # };
      };
    };
}
