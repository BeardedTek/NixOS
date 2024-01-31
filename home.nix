{ pkgs, ... }:
{
    home.username = "beardedtek";
    home.homeDirectory = "/home/beardedtek";
    programs.home-manager.enable = true;
    services = {
      kdeconnect = {
        enable = true;
        indicator = true;
      };
    };
    home.packages = with pkgs; [
        # OBS Studio
        obs-studio
        obs-studio-plugins.obs-3d-effect
        obs-studio-plugins.waveform
        obs-studio-plugins.obs-vaapi
        obs-studio-plugins.obs-hyperion # BROKEN
        obs-studio-plugins.obs-vkcapture
        obs-studio-plugins.input-overlay
        obs-studio-plugins.obs-source-record
        obs-studio-plugins.obs-replay-source
        obs-studio-plugins.obs-source-switcher
        obs-studio-plugins.obs-gradient-source
#        obs-studio-plugins.obs-backgroundremoval
        obs-studio-plugins.advanced-scene-switcher
        obs-studio-plugins.droidcam-obs

        # Chat Clients
        element-desktop
        telegram-desktop
        discord
        slack

        # Internet Stuffs
        google-chrome
        
        # Video Players
        vlc

    ];
    home.stateVersion = "23.11";
}
