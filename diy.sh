#!/bin/bash
#=================================================
# OneCloud ImmortalWrt 自定义配置脚本
# Description: DIY script for OneCloud
#=================================================

# 修改默认 IP 地址
echo "修改默认 IP 地址为 192.168.2.2"
sed -i 's/192.168.1.1/192.168.2.2/g' package/base-files/files/bin/config_generate

# 修改默认主机名
echo "修改主机名为 OneCloud"
sed -i 's/ImmortalWrt/OneCloud/g' package/base-files/files/bin/config_generate

# 修改默认时区
echo "修改时区为 Asia/Shanghai"
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#=================================================
# 安装第三方插件（可选）
#=================================================

# UA2F - 绕过校园网检测
# echo "安装 UA2F 插件"
# git clone --depth=1 https://github.com/EOYOHOO/UA2F.git package/UA2F

# RKP-IPID - 绕过运营商检测
# echo "安装 RKP-IPID 插件"
# git clone --depth=1 https://github.com/EOYOHOO/rkp-ipid.git package/rkp-ipid

# PassWall - 科学上网
# echo "安装 PassWall 插件"
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall.git package/passwall

# OpenClash - 代理工具
# echo "安装 OpenClash 插件"
# git clone --depth=1 https://github.com/vernesong/OpenClash.git package/openclash

# AdGuard Home - 广告过滤
# echo "安装 AdGuard Home 插件"
# git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome.git package/adguardhome

# DDNS-GO - 动态域名解析
# echo "安装 DDNS-GO 插件"
# git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go

# iStore - 应用商店
# echo "安装 iStore 应用商店"
# git clone --depth=1 https://github.com/linkease/istore.git package/istore
# git clone --depth=1 https://github.com/linkease/nas-packages.git package/nas-packages
# git clone --depth=1 https://github.com/linkease/nas-packages-luci.git package/nas-packages-luci

#=================================================
# 自定义软件包（可选）
#=================================================

# 移除不需要的默认软件包
# echo "移除不需要的软件包"
# ./scripts/feeds uninstall luci-app-turboacc
# ./scripts/feeds uninstall luci-app-wol
# ./scripts/feeds uninstall luci-app-accesscontrol

#=================================================
# 修改默认主题（可选）
#=================================================

# 设置默认主题为 Argon
# echo "设置默认主题"
# git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
# git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

#=================================================
# 自定义文件（可选）
#=================================================

# 修改欢迎标语
# echo "修改欢迎标语"
# echo "OneCloud ImmortalWrt - Built by GitHub Actions" > package/base-files/files/etc/banner

# 添加自定义启动脚本
# cat > package/base-files/files/etc/rc.local << EOF
# # Put your custom commands here
# exit 0
# EOF

#=================================================
# 其他自定义设置
#=================================================

# 设置密码为空（默认）
# sed -i 's/root:x:/root::/' package/base-files/files/etc/shadow

# 调整网络设置
# echo "配置网络参数"
# sed -i "s/option gateway '192.168.1.1'/option gateway '192.168.2.1'/g" package/base-files/files/bin/config_generate

echo "========================================="
echo "DIY 脚本执行完成！"
echo "默认 IP: 192.168.2.2"
echo "网关: 192.168.2.1"
echo "用户名: root"
echo "密码: 空（留空登录）"
echo "========================================="
