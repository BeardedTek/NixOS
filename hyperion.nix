{pkgs, ...}:
{
  systemd.services = {
    hyperiond = {
      description = "Start hyperion.ng server";
      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];
      enable = true;
      serviceConfig = {
        User = "beardedtek";
        ExecStart = with pkgs; ''${hyperion-ng}/bin/hyperiond --service'';
        TimeoutStopSec = "5";
        KillMode="mixed";
        Restart="on-failure";
        RestartSec="2";
      };
    };
  };
  environment.systemPackages = with pkgs; [ hyperion-ng ];
}
