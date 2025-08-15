# 1) repo + clé
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-warp.list

# 2) install
sudo apt update && sudo apt install cloudflare-warp -y

# 3) run + register
sudo systemctl enable --now warp-svc
warp-cli register
warp-cli set-mode warp
warp-cli connect

# (option Teams/Zero Trust)
# warp-cli teams-enroll <ton_org_zero_trust>

# 4) vérifier
curl https://www.cloudflare.com/cdn-cgi/trace | egrep 'warp|ip|colo'
