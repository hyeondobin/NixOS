{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.d2coding
    nerd-fonts.jetbrains-mono
  ];
  imports = [
    ./nix.nix
    ./emacs.nix
  ];
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
