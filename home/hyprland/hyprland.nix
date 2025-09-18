{ config, lib, ... }:{
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    sourceFirst = true;
    settings = {
      source = [ "${toString ./macchiato.conf}" ];

      ################
      ### MONITORS ###
      ################
      "$scale" = 1;
      monitor = ", preferred, auto, $scale";

      ##################
      ###  VARIABLES ###
      ##################
      "$mainMod" = "SUPER";
      "$shiftMod" = "SUPER SHIFT";
      "$ctrlMod" = "SUPER CTRL";
      "$altMod" = "SUPER ALT";
      "$terminal" = "kitty";
      "$emacs" = "emacs";
      "$www" = "vivaldi";

      ################
      ### ENV VARS ###
      ################
      env = [
        "XCURSOR_SIZE, 24"
        "HYPRCURSOR_SIZE, 24"
      ];
      
      #################
      ### AUTOSTART ###
      #################
      exec-once = [
        "$terminal"
        "bitwarden &"
        "waybar"
      ];

      #####################
      ### LOOK AND FEEL ###
      #####################
      general = {
        gaps_in = 5;
        gaps_out = 3;
        border_size = 3;
        "col.active_border" = "$lavender $peach 30deg";
        "col.inactive_border" = "$crust";
      };
      decoration = {
        shadow = {
          enabled = false;
          offset = "0 5";
          color = "rgba(1a1a1aee)";
        };
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 0.8;
      };
      animations = {
        enabled = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      #############
      ### INPUT ###
      #############
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0; # -1.0 ~ 1.0, 0는 기본값
        touchpad = {
          natural_scroll = false;
        };
      };
      
      ##################
      ### WINDOWRULE ###
      ##################
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
      ];
      windowrulev2 = [
        "workspace name:Emacs, class:^(emacs).*$"
        "workspace name:Vivaldi, class:^(vivaldi).*$"
	"workspace 1, class:^(kitty).*$"
	"workspace name:Vimb, class:^(vimb).*$"
      ];

      ################
      ### KEYBINDS ###
      ################
      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"

        # Moving around windows
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, down, movefocus, d"
        "$mainMod, up, movefocus, u"

        # Special workspace for emacs
        "$mainMod, E, exec, pgrep emacs && hyprctl dispatch workspace name:Emacs || $emacs"
        "$shiftMod, E, movetoworkspace, name:Emacs"
	"$ctrlMod, E, exec, $emacs"

        "$mainMod, B, exec, pgrep vivaldi && hyprctl dispatch workspace name:Vivaldi || $www"
        "$shiftMod, B, movetoworkspace, name:Vivaldi"
        "$ctrlMod, B, exec, $www"

	"$mainMod, V, exec, pgrep vimb && hyprctl dispatch workspace name:Vimb || vimb"
	"$shiftMod, V, movetoworkspace, name:Vimb"

      ] ++ (
        # switch to workspaces with main mod + 0-9
        builtins.concatLists (builtins.genList (i:
          let workspace = i + 1;
          in [
            "$mainMod, code:1${toString i}, workspace, ${toString workspace}"
            "$shiftMod, code:1${toString i}, movetoworkspace, ${toString workspace}"
          ]) 9)
      );
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
