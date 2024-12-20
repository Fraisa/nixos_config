# Dell XPS 9520
{ config, lib, pkgs, ... }:
{
  imports = [
    ../_mixins/services/tailscale.nix
    ../_mixins/services/syncthing.nix
    ../_mixins/services/flatpak.nix
    ../_mixins/services/pipewire.nix
    ../_mixins/virt
    ../_mixins/streaming
  ];

  hardware.bluetooth.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "usbmon" ];
  boot.extraModulePackages = [ ];

  # See https://github.com/Mic92/envfs (for scripts to get access to /bin/bash etc.)
  services.envfs.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
  '';

  # device = "/dev/disk/by-uuid/bbeecbed-7c0a-43aa-988e-0a8e1506c1bc";
  # device = "/dev/disk/by-uuid/437b";


  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/bbeecbed-7c0a-43aa-988e-0a8e1506c1bc";
      fsType = "ext4";
      options = [ "relatime" "discard" "errors=remount-ro" ];
    };

  # fileSystems."/boot" =
  #   {
  #     device = "/dev/disk/by-uuid/AC20-D1A9";
  #     fsType = "vfat";
  #   };

  # fileSystems."/home" =
  #   {
  #     device = "/dev/disk/by-uuid/45052b78-e660-4e31-98c2-1f4682a93ba1";
  #     fsType = "ext4";
  #     options = [ "relatime" "discard" "errors=remount-ro" ];
  #   };

  # fileSystems."/nix" =
  #   {
  #     device = "/dev/disk/by-uuid/45052b78-e660-4e31-98c2-1f4682a93ba1";
  #     fsType = "ext4";
  #     options = [ "relatime" "discard" "errors=remount-ro" ];
  #   };

  # zramSwap.enable = true;
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # In order for VSCode remote to work
  programs.nix-ld.enable = true;
  #programs.talon.enable = true;
  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    

    obs-studio
    remmina
    kicad

    prusa-slicer
    wireshark

    # reaper # Musik
    (pkgs.python3.withPackages (ps: with ps; 
    [ 
      pyserial 
      python-lsp-server 
      matplotlib 
      qt5
    ]))

    qtcreator
  ];

  services.printing.enable = true;


  # hardware = {
  #   nvidia = {
  #     # Enable the legacy 390.xx series driver for older NVIDIA GPUs.
  #     # This series supports your GT 415M card.
  #     nvidiaLegacy390 = {
  #       enable = true;
  #     };
  #   };
  # };

  # Optional: If your card is Optimus and you want to use both Intel and NVIDIA graphics
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;  # If you need 32-bit OpenGL support (e.g., for Steam).
  };
}
