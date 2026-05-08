{ pkgs, ... }:
let
  files = "/etc/zapret"; 
  BIN = "${files}/bin/";  
  LISTS = "${files}/lists/";
  GameFilter = "1024-65535";
in
{
  networking.firewall.extraCommands = ''
    ip46tables -t mangle -I POSTROUTING -p tcp -m multiport --dports 80,443,2053,2083,2087,2096,8443,1025:65535 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:9 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
    ip46tables -t mangle -I POSTROUTING -p tcp -m multiport --dports 80,443,2053,2083,2087,2096,8443,1025:65535 -m connbytes --connbytes-dir=reply --connbytes-mode=packets --connbytes 1:3 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
    ip46tables -t mangle -A POSTROUTING -p udp -m multiport --dports 443,19294:19344,50000:50100,1025:65535 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:9 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
  '';

  systemd.services.zapret = {
    enable = true;
    description = "DPI bypass service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ]; 
    serviceConfig = {
      ExecStart = ''
        ${pkgs.zapret}/bin/nfqws --pidfile=/run/nfqws.pid --qnum=200 \
          --filter-udp=443 --hostlist="${LISTS}zapret-hosts-user.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="${BIN}quic_initial_www_google_com.bin" --new \
          --filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="${BIN}quic_initial_www_google_com.bin" --new \
          --filter-tcp=80,443,2053,2083,2087,2096,8443 --hostlist="${LISTS}zapret-hosts-user.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fake-tls="${BIN}tls_clienthello_www_google_com.bin" --new \
          --filter-tcp=80,443,1024-65535 --ipset="${LISTS}ipset-game.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fake-tls="${BIN}tls_clienthello_4pda_to.bin" --new \
          --filter-udp=1024-65535 --ipset="${LISTS}ipset-game.txt" --dpi-desync=fake --dpi-desync-autottl=2 --dpi-desync-repeats=12 --dpi-desync-any-protocol=1 --dpi-desync-fake-unknown-udp="${BIN}quic_initial_www_google_com.bin" --dpi-desync-cutoff=n2
      '';
      Type = "simple";
      Restart = "always";
    };
  };
}

