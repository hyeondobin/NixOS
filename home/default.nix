{pkgs, config, ... }:{
  home.stateVersion = "25.05";
   xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh"; 
  imports = [
    ./hyprland
    ./lsp.nix
    ./cli.nix
    ./waybar.nix
  ];
}
