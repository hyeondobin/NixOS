{ config, pkgs, inputs, callPackage, ... }:
let
  in
{
  nixpkgs.overlays = [
    (import inputs.emacs-overlay)
  ];
  environment.systemPackages = [
    ((pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (
      epkgs: [ epkgs.vterm ]
    ))
    pkgs.cmake
    pkgs.gnumake
  ];
}
