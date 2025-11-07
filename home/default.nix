{pkgs, config, ... }:{
    home.stateVersion = "25.05";
    xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh"; 
    imports = [
        ./hyprland
        ./cli.nix
        ./waybar
        ./git.nix
        ./vimb.nix
        ./messanger.nix
        ./nvim.nix
    ];


}
