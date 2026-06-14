  { pkgs, ...}: {
  users.users = {
    flaemer = {
     isNormalUser = true;
     extraGroups = [ "wheel" "audio" "video" "disk" "lp" "network" "input" "uinput" "networkmanager" "plugdev" "jellyfin" "render" "adbuser" "docker" "libvirtd" "kvm" ]; 
     packages = with pkgs; [ tree ];	
   }; 
   
    diddy = { 
      isNormalUser = true;
      description = "ummeggsyeaheggstrueeggsln11,col55";
      extraGroups = [ "audio" "video" "networkmanager" "plugdev" "input" "render" "adbuser" "uinput" ];
    };
};    
       time = {
        timeZone = "Asia/Krasnoyarsk";
        hardwareClockInLocalTime = true;
    };
 }

 
