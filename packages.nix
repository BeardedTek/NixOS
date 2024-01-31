{ pkgs, ... }:
{
  # Allow non-free (Unfree) packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # System Packages
    nano # Why would I ever want vim to touch my system :)
    wget
    sbctl
    niv
    tailscale
    gparted
    distrobox
    appimage-run

    # Graphics
    gimp-with-plugins

    # Development
    vscode
    git
    python312

    # KDE / QT Specific
    libsForQt5.discover
    libsForQt5.packagekit-qt
    libsForQt5.yakuake
    libsForQt5.kdenlive
    libportal-qt5
    kmplayer
    okular
    spectacle
    kcalc
    krdc
    

    # Gnome Compatibility
    gnome.adwaita-icon-theme
    gnomeExtensions.appindicator
    gsettings-qt
    gsettings-desktop-schemas
    dbus
    glib
    xdg-utils

    # Games
    protonup-qt
    lutris
    mupen64plus
    xemu
    yuzu-mainline    
    # Wine
    wineWowPackages.staging
    winetricks

  ];

  programs.steam.enable = true;
}
