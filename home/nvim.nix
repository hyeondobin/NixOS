{ pkgs, config, ... }:{
    home.file = { 
    	".config/nvim" = {
            source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repo/dotfiles/Configs/nvim/.config/nvim";
	    recursive = true;
	    };
	    };
    home.packages = [
        pkgs.gcc
	pkgs.ripgrep
    ];
	    }
