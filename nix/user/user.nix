  { pkgs, ...}: {
  users.users.flaemer = {
     isNormalUser = true;
     extraGroups = [ "wheel" "audio" "video" "disk" "lp" "network" "input" "networkmanager" "plugdev" "jellyfin" "render" ]; 
     packages = with pkgs; [
       tree
     ];	
 };      
       time = {
        timeZone = "Asia/Krasnoyarsk";
        hardwareClockInLocalTime = true;
    };
 }
 
