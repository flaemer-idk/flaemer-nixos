{ config, lib, pkgs, modulesPath, ... }:{
imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix") 
];

boot = { 
  kernelModules = [ "kvm-intel" "i915" "amdgpu" ];
  initrd = {
    availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
    supportedFilesystems = [ "vfat" "ext4" ];
};

  kernelParams = [
    "intel_pstate=passive" 
    "iommu=pt" 
    "radeon.cik_support=0" "amdgpu.cik_support=1"
    "radeon.si_support=0" "amdgpu.si_support=1"
    "amdgpu.dc=1" "amdgpu.dpm=1"
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
};

fileSystems = {
  "/" = {
    device = "/dev/disk/by-label/NixosRoot";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "discard" "errors=remount-ro" ];
  };
  "/boot" = {
    device = "/dev/disk/by-label/EFI";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  "/home" = {
    device = "/dev/disk/by-label/hi";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "discard" "errors=remount-ro" ];
  };
};

networking.useDHCP = lib.mkDefault true;  
hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
