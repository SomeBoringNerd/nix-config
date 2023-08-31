{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.profiles.pipewire;
in
{
  options.profiles.pipewire.enable = mkEnableOption "Enable the PipeWire audio/video daemon instead of PulseAudio";
  options.profiles.pipewire.lowlatency.enable = mkEnableOption "Enable low-latency audio configuration for PipeWire";

  config = mkMerge [
    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        pulseaudio
        helvum
        easyeffects
      ];
      # https://nixos.wiki/wiki/PipeWire
      sound.enable = false;
      hardware.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    })
    (mkIf (!cfg.enable) {
      sound.enable = true;
      hardware.pulseaudio = {
        enable = true;
        package = pkgs.pulseaudioFull;
        support32Bit = true;
      };
    })
  ];
}