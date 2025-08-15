# service déjà lancé par l’install, sinon :
sudo systemctl enable --now warp-svc

# 1) enregistrer l’appareil (nouvelle syntaxe)
warp-cli --accept-tos registration new

# 2) choisir le mode (nouvelle commande `mode`)
warp-cli mode warp         # ou: warp+doh, doh, proxy…

# 3) se connecter
warp-cli connect

# 4) vérifier
curl https://www.cloudflare.com/cdn-cgi/trace | egrep 'warp|ip|colo'
# → doit afficher: warp=on
