{ pkgs, ... }:
{
  users = {
    mutableUsers = false;
    users = {
      beardedtek = {
        isNormalUser = true;
        description = "BeardedTek";
        createHome = true;
        home = "/home/beardedtek";
        group = "beardedtek";
        extraGroups = [ 
          "wheel"           # Enable sudo
          "docker"          # Enable docker
          "systemd-journal"
          "dialout" # Serial port access
        ];
        hashedPassword = (builtins.readFile ./secrets/pw_beardedtek);
        openssh.authorizedKeys.keys = [
          (builtins.readFile ./secrets/sshkey_beardedtek)
        ];
        packages = with pkgs; [ ];
        uid = 1000;
      };
      root = {
        hashedPassword = (builtins.readFile ./secrets/pw_root);
      };
    };
    groups = {
      # Setup custom groups
      beardedtek = {
        name = "beardedtek";
        members = [ "beardedtek" ];
        gid = 1000;
      };
    };
  };
}
