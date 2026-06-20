{ config, lib, pkgs, modulesPath, ... }:{
imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
];

boot = { 
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "ehci_pci" "usbhid" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
    kernelModules = [ "kvm-amd" ];
    kernel.sysctl = {
        "vm.dirty_writeback_centisecs" = 6000;
        "vm.dirty_expire_centisecs" = 6000;
        "vm.dirty_ratio" = 40;
        "vm.dirty_background_ratio" = 10;
    };
};

fileSystems."/" = { 
    device = "/dev/disk/by-label/ServerRoot";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "errors=remount-ro" "commit=60" ];   
};

fileSystems."/boot" = {
    device = "/dev/disk/by-label/EFI";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
};

fileSystems."/idkselfhost" = { 
    device = "/dev/disk/by-label/idkselfhost";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "errors=remount-ro" "commit=60" ];   
};

swapDevices = [ ];
hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
