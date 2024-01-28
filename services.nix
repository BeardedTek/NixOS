{
  # Enable Services
  services = {
    openssh = {
      enable = true;
    };
  };
  virtualisation = {
    podman = {
      enable = true;

      dockerCompat = true;

      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
