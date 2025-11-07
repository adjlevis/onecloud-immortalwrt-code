#!/bin/bash
#=================================================
# OneCloud ImmortalWrt 自定义配置脚本（B全功能 版）
#=================================================
set -euo pipefail

echo "[DIY] Start OneCloud customizations"

# 校验运行路径（必须在源码根目录）
if [ ! -x "./scripts/feeds" ] || [ ! -d "package/base-files/files" ]; then
  echo "[DIY] 请在 OpenWrt/ImmortalWrt 源码根目录运行（应存在 ./scripts/feeds 与 package/base-files/files）"
  exit 1
fi

CFG_GEN="package/base-files/files/bin/config_generate"

echo "[DIY] 修改默认 IP 为 192.168.2.2"
sed -i "s/\(option ipaddr '\)192\.168\.1\.1\(')\?/\1192.168.2.2\2/g" "$CFG_GEN" || true
sed -i 's/192.168.1.1/192.168.2.2/g' "$CFG_GEN" || true

echo "[DIY] 修改主机名为 OneCloud"
sed -i "s/\(option hostname '\)ImmortalWrt\(')\?/\1OneCloud\2/g" "$CFG_GEN" || true
sed -i 's/ImmortalWrt/OneCloud/g' "$CFG_GEN" || true

echo "[DIY] 写入 uci-defaults（时区/zonename/网关）"
mkdir -p files/etc/uci-defaults
cat > files/etc/uci-defaults/99-onecloud-settings << 'EOF'
#!/bin/sh
uci set system.@system[0].timezone='CST-8'
uci set system.@system[0].zonename='Asia/Shanghai'
uci commit system

# 如确有上游网关 192.168.2.1 才保留，默认 LAN 不需要网关
uci set network.lan.gateway='192.168.2.1'
uci commit network

# 可选优化
# uci set dhcp.@dnsmasq[0].cachesize='512'
# uci set system.@system[0].log_size='64'
# uci commit dhcp
# uci commit system

exit 0
EOF
chmod +x files/etc/uci-defaults/99-onecloud-settings

echo "[DIY] 自定义 banner"
mkdir -p files/etc
cat > files/etc/banner << 'EOF'
  ___              ____ _                 _ 
 / _ \ _ __   ___ / ___| | ___  _   _  __| |
| | | | '_ \ / _ \ |   | |/ _ \| | | |/ _` |
| |_| | | | |  __/ |___| | (_) | |_| | (_| |
 \___/|_| |_|\___|\____|_|\___/ \__,_|\____|
 ---------------------------------------------
 ImmortalWrt for OneCloud - Built by CI
 Default IP: 192.168.2.2  |  Gateway: 192.168.2.1
 ---------------------------------------------
EOF

# 第三方插件（可选）：
# 方式A：通过 feeds 引入（推荐，依赖完整）
# if ! grep -q 'passwall-packages' feeds.conf.default 2>/dev/null; then
#   echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> feeds.conf.default
# fi
# if ! grep -q '^src-git passwall ' feeds.conf.default 2>/dev/null; then
#   echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> feeds.conf.default
# fi
# ./scripts/feeds update passwall_packages passwall
# ./scripts/feeds install -a -p passwall_packages
# ./scripts/feeds install -a -p passwall

# 方式B：直接 clone（简单但需自行处理依赖）
# git clone --depth=1 https://github.com/vernesong/OpenClash.git package/openclash
# git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome.git package/adguardhome
# git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
# git clone --depth=1 https://github.com/linkease/istore.git package/istore
# git clone --depth=1 https://github.com/linkease/nas-packages.git package/nas-packages
# git clone --depth=1 https://github.com/linkease/nas-packages-luci.git package/nas-packages-luci

echo "[DIY] Done."
