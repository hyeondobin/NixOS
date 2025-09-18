{
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.overlays = [
    (import inputs.emacs-overlay)
  ];
  environment.systemPackages = [
    ((pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (epkgs: [
      epkgs.vterm
      epkgs.treesit-grammars.with-all-grammars
    ]))
    pkgs.cmake
    pkgs.gnumake
    pkgs.ripgrep

    # Language Servers
    pkgs.nil # nix

    # formatter
    pkgs.nixfmt-rfc-style # nix lang
  ];
}
