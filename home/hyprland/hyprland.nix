{ pkgs, config, lib, inputs, ... }:{
    home.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    };
    wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
            "$hyprMod" = "SUPER SHIFT CTRL ALT";
            "$terminal" = "ghostty";
            "$emacs" = "emacs";
            # ref: https://www.reddit.com/r/wayland/comments/1cywhh2/anyone_still_seeing_flickering_in/
            "$webBrowser" = "vivaldi --disable-gpu";
            "$bitwarden" = "bitwarden";
            "$chrome" = "googel-chrome-stable --disable-gpu";

                ################
                ### ENV VARS ###
                ################
                # env = [
                #     "XCURSOR_SIZE, 24"
                #     "HYPRCURSOR_SIZE, 24"
                # ];

                #################
                ### AUTOSTART ###
                #################
                exec-once = [
                    "$terminal"
                    "$bitwarden"
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
                    range = 4;
                    render_power = 3;
                    color = "rgba(1a1a1aee)";
                };
                rounding = 10;
                rounding_power = 2;
                active_opacity = 1.0;
                inactive_opacity = 0.9;
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
                "pseudo, class:fcitx"
                "suppressevent maximize, class:.*"
                "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
            ];
            windowrulev2 = [
                "nofocus, class:^$, title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
                "suppressevent maximize, class:.*"
                "workspace name:Emacs, class:^(emacs).*$"
                "workspace name:Term, class:^(kitty)$"
                "workspace name:Term, class:^.*(wezterm)$"
                "workspace name:Term, initialTitle:^([Gg]hostty)"
                "workspace name:Notion, class:^([Nn]otion)"
                "workspace name:WWW, class:^([Vv]ivaldi).*$"
                "workspace name:Vimb, class:^(vimb).*$"
                "workspace special:Bitwarden, class:^([Bb]itwarden)"
                "workspace special:Discord, class:^([Dd]iscord)"
                "workspace special:Music, class:^([Gg]oogle-chrome)"
                "workspace special:Sns, class:^.*(telegram).*$"
            ];

            ################
            ### KEYBINDS ###
            ################
            bind = [
                # terminal
                "$mainMod, T, exec, pgrep $terminal && hyprctl dispatch workspace name:Term || $terminal"
                "$ctrlMod, T, exec, $terminal"
                "$shiftMod, T, movetoworkspace, name:Term"

                # notion
                "$mainMod, N, workspace, name:Notion" # no detecting for electron apps
                "$ctrlMod, N, exec, notion-app --enable-wayland-ime --ozone-platform=wayland"
                "$shiftMod, N, movetoworkspace, name:Notion"

                # music
                "$mainMod, M, togglespecialworkspace, Music"
                "$ctrlMod, M, exec, $chrome https://music.youtube.com"
                "$shiftMod, M, movetoworkspace, special:Music"

                # master layout
                "$mainMod, R, layoutmsg, swapwithmaster master"
                "$shiftMod, R, layoutmsg, focusmaster"

                # vavaldi browser
                "$mainMod, B, exec, pgrep vivaldi && hyprctl dispatch workspace name:WWW || $webBrowser"
                "$ctrlMod, B, exec, $webBrowser"
                "$shiftMod, B, movetoworkspace, name:WWW"

                # discord
                "$mainMod, D, togglespecialworkspace, Discord"
                "$ctrlMod, D, exec, discord --enable-wayland-ime --ozone-platform=wayland"
                "$shiftMod, D, movetoworkspace, special:Discord"

                # bitwarden
                "$mainMod, W, togglespecialworkspace, Bitwarden"
                "$ctrlMod, W, exec, $bitwarden"
                "$shiftMod, W, movetoworkspace, special:Bitwarden"

                # screenshot
                ", PRINT, exec, hyprshot -m output"
                "$mainMod, PRINT, exec, hyprshot -m window"
                "$shiftMod, PRINT, exec, hyprshot -m region"

                # the default example binds
                "$mainMod, C, killactive"
                "$mainMod, P, pseudo"
                "$mainMod, J, togglesplit"
                "$mainMod, SPACE, exec, $menu"

                # Moving around windows
                "$mainMod, left, movefocus, l"
                "$mainMod, right, movefocus, r"
                "$mainMod, down, movefocus, d"
                "$mainMod, up, movefocus, u"
                # also with vim bindings
                "$mainMod, h, movefocus, l"
                "$mainMod, j, movefocus, d"
                "$mainMod, k, movefocus, u"
                "$mainMod, l, movefocus, r"

                # audio control, refer to submaps below
                "$ctrlMod SHIFT, A, submap, audio"
            ] ++ (
                    # switch to workspaces with main mod + 0-9
                    # keycode can be obtained with wev(wayland event viewer)
                    # https://wiki.hypr.land/Configuring/Binds/#uncommon-syms--binding-with-a-keycode
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
        submaps = {
            audio = {
                settings = {
                    bind = [
                        ", l, exec, pactl set-sink-port 0 analog-output-lineout"
                        ", h, exec, pactl set-sink-port 0 analog-output-headphones"
                        ", escape, submap, reset"
                    ];
                };
            };
        };
        # plugins = [
        #     pkgs.hyprlandPlugins.
        # ];
    };
}
