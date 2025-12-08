{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.d2coding
  ];
  imports = [
    ./nix.nix
    ./qmk.nix
    # ./emacs.nix
  ];
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
}
