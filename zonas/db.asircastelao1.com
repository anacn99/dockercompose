$TTL    3600
@       IN      SOA     ns.asircastelao1.com. acamposnaya.danielcastelao.org. (
                   2022051001           ; Serial
                         3600           ; Refresh [1h]
                          600           ; Retry   [10m]
                        86400           ; Expire  [1d]
                          600 )         ; Negative Cache TTL [1h]
;
@       IN      NS      ns.asircastelao1.com.
ns     IN      A       10.1.0.254
test   IN      A       10.1.0.2
alias  IN      CNAME   test
@    IN      TXT     "bebida favorita=zumo de piña"