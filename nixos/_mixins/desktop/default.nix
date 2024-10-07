{ desktop, lib, pkgs, ... }: {
  imports = [
  ]
  ++ lib.optional (builtins.pathExists (./. + "/${desktop}.nix")) ./${desktop}.nix;

  services.xserver.enable = true;
  services.xserver.libinput.enable = true;

  services.xserver = {
    autoRepeatDelay = 250;
    autoRepeatInterval = 50;
    xkbOptions = "eurosign:e,caps:ctrl_modifier";
    layout = "se";  # Sets Swedish keyboard layout
  };



  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    vlc
    kitty
    spotify
  ];

}
