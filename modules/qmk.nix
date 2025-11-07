{ pkgs,... }:{
    services.udev = {
        enable = true;
        packages = [
            pkgs.qmk-udev-rules
            pkgs.vial
        ];
    };
    environment.systemPackages = [
        # pkgs.qmk
        pkgs.dfu-util
            pkgs.python312
            pkgs.python312Packages.uv
    ];
}
