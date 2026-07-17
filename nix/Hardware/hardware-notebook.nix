{ config, lib, pkgs, modulesPath, ... }:{
imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix") 
];

boot = { 
  kernelModules = [ "kvm-intel" "i915" ];
  kernelPackages = pkgs.linuxPackages_zen;
  blacklistedKernelModules = [ "radeon" "amdgpu" ];
  initrd = {
    availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
    supportedFilesystems = [ "vfat" "ext4" ];
};

  kernelParams = [
    "intel_pstate=passive" 
    "iommu=pt" 
  ];
};

fileSystems = {
  "/" = {
    device = "/dev/disk/by-label/NixosRoot";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "discard" "errors=remount-ro" ];
  };
  "/boot" = {
    device = "/dev/disk/by-uuid/C140-1CAE";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  "/home" = {
    device = "/dev/disk/by-label/hi";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "discard" "errors=remount-ro" ];
  };
};
services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1002", ATTR{device}=="0x6900", ATTR{power/control}="auto", ATTR{remove}="1"
  '';
networking.useDHCP = lib.mkDefault true;  
hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
