{ pkgs, ... }: {
  home.packages = [
    pkgs.fastfetch
  ];
  programs.fish = {
    enable = true;
    preferAbbrs = true;
    shellAbbrs = {
      amx = "alsamixer -g";
      cat = "bat ";
      cp = "cp -iv ";
      eh = "neovide ~/repo/dotfiles/hyprland/hyprland.conf";
      en = "neovide /etc/nixos/";
      ff = "clear && fastfetch";
      htop = "btop ";
      kcc = "kanata --check -c ~/repo/dotfiles/kanata/kanata-miryoku.kbd"; # Kanata Check Config
      krs = "systemctl --user restart kanata-custom.service"; # Kanata Restart Service
      KKK = "pkill kanata | kanata -c ~/repo/dotfiles/kanata/kanata-miryoku.kbd";
      l = "eza -lah --group-directories-first ";
      lt = "eza -lahgT --group-directories-first ";
      lz = "lazygit";
      mkdir = "mkdir -pv ";
      mv = "mv -iv ";
      nfu = "nix flake update &| nom ";
      nfud = "nix flake update localDots --flake /etc/nixos &| nom";
      nhs = "nh home switch --ask";
      nhfs = "nh home switch ";
      nhsf = "nh home switch ";
      nhsu = "nh home switch --ask --update";
      nhsuf = "nh home switch --update";
      nos = "nh os switch --ask";
      nosf = "nh os switch ";
      nosu = "nh os switch --ask --update";
      nosuf = "nh os switch --update";
      pk = "pkill -e ";
      pkill = "pkill -e ";
      rm = "rm -iv ";
      sa = "ssh-add";
      sofi = ". ~/.config/fish/config.fish";
      vi = "neovide ";
      z = "cd ";
      zi = "cdi ";
    };
    plugins = [
    ];
    # ref: https://www.reddit.com/r/fishshell/comments/kk62hx/how_to_expand_an_abbreviation_without_a_space_at/
    interactiveShellInit = ''
      set fish_greeting "Mao Myao"
      bind -M insert \cp up-or-search
      bind -M insert \cn down-or-search
      bind -M insert " " expand-abbr or self-insert
      bind -M insert \cf forward-word
      bind -M insert \cy accept-autosuggestion
      # https://stackoverflow.com/questions/61520166/how-to-create-a-key-binding-that-inserts-text-in-the-fish-shell
      bind -M insert \en "commandline -i '&| nom'"

      fastfetch
    '';
  };
}
