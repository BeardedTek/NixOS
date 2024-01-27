{ config, pkgs, lib, ... }:
let
  sources = import ./nix/sources.nix;
  lanzaboote = import sources.lanzaboote;
in
{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./users.nix
      ./packages.nix
      ./services.nix
      ./nvidia.nix
      ./kde.nix
      ./network.nix
      ./tailscale.nix
      lanzaboote.nixosModules.lanzaboote
    ];
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };

  # Set your time zone.
  time.timeZone = "America/Anchorage";

  # Set nix Version
  system.stateVersion = "23.11";

  # Allow Unfree Software
  nixpkgs.config.allowUnfree = true;

}

