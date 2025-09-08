{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.d2coding
  ];
  imports = [
    ./nix.nix
    ./emacs.nix

  ];
}
