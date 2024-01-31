{ config, pkgs, ... }:
{
  boot.kernelModules = [
    "i2c-dev"
    "i2c-piix4"
  ];
  services.hardware.openrgb.enable = true;
  environment.systemPackages = with pkgs; [
    openrgb
    i2c-tools
  ];
}
