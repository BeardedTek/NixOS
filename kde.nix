{ config, lib, pkgs, ... }:
{
  # Insert custom SDDM theme into nix store
  environment.systemPackages = with pkgs; [
    (callPackage ./sddm-theme.nix{}).deathstar-sddm-theme
  ];

  services = {
    dbus = {
      enable = true;
    };
    xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
          # Set custom SDDM theme
          theme = "deathstar-sddm-theme";
        };
        autoLogin = {
          enable = true;
          user = "beardedtek";
        };
      };
      desktopManager = {
        plasma5.enable = true;
      };
    };
    flatpak.enable = true;
    packagekit.enable = true;
    fwupd.enable = true;
    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
      ];
  };
  qt = {
    enable = true;
  };

}
