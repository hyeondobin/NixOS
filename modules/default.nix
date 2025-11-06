{ pkgs, ... }:
{
    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
    ];
    imports = [
        ./nix.nix
        # ./emacs.nix
    ];
    # hardware.bluetooth.enable = true;
    # services.blueman.enable = true;
    environment.systemPackages = with pkgs; [
        wl-clipboard
    ];
}
