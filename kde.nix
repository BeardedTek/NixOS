{ config, lib, pkgs, ... }:
{

  services = {
    xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
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
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
  
}
