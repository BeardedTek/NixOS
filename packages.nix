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

     # Gaming
     steam     
   ];
}
