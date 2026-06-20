{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_18;
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ "amdgpu" ];
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  environment.sessionVariables = {
    RADV_PERFTEST = "nggc";
    mesa_glthread = "true";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/745f87ab-655a-48f4-8c63-1eb25fc4dc09";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/BB84-57E5";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/e9cbda06-f83c-45fc-8712-55e1ac305685";
    fsType = "ext4";
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}