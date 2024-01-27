{
  # Setup Networking
  networking = {
    hostName= "pascal";
    nameservers = [
      "192.168.2.22"
      "9.9.9.9"
      ];
    enableIPv6 = false;
    firewall = {
      enable = false;
      allowedTCPPorts = [
        22
        80
        443
        32400
        5000
        9000
      ];
    };
  };
}
