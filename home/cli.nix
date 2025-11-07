{ pkgs, config, ... }:
{
    home.packages = [
        pkgs.fastfetch
        pkgs.eza
    ];
    home.file.".config/fish" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repo/dotfiles/Configs/fish/.config/fish";
        recursive = true;
    };
    programs.ghostty = {
        enable = true;
    };
}
