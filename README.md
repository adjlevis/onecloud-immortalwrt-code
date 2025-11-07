# 🔥 OneCloud ImmortalWrt 自动编译

> 迅雷玩客云 (OneCloud) ImmortalWrt 固件自动构建工具  
> 每月自动编译最新线刷固件，支持手动触发构建

## 📋 项目说明

本项目使用 GitHub Actions 自动编译适用于**迅雷玩客云 (OneCloud)** 的 ImmortalWrt 固件。

### 💻 设备信息

- **设备名称**: 迅雷玩客云 / Thunder OneCloud
- **CPU**: Amlogic S805 (Cortex-A5 四核 @ 1.5GHz)
- **架构**: ARMv7-A (32位)
- **内存**: 1GB DDR3
- **存储**: 8GB eMMC
- **网口**: 千兆以太网 (1000M)
- **USB**: 4x USB 2.0

### ✨ 固件特性

- ✅ 线刷版固件（直接刷入 eMMC）
- ✅ 每月自动构建最新版本
- ✅ 支持手动选择内核版本（6.6/6.7/6.9）
- ✅ 完整的 USB 存储支持
- ✅ Samba 文件共享
- ✅ DDNS、UPnP、ZeroTier
- ✅ 网络加速（Turbo ACC）
- ✅ 流量监控、定时重启
- ✅ KMS 激活服务器
- ✅ 完整 IPv6 支持

## 🚀 快速开始

### 方法一：Fork 本仓库（推荐）

1. **Fork 本仓库**
   - 点击右上角 "Fork" 按钮
   - 等待 Fork 完成

2. **启用 Actions**
   - 进入你 Fork 的仓库
   - 点击 "Actions" 标签
   - 点击 "I understand my workflows, go ahead and enable them"

3. **手动触发构建**
   - 点击左侧 "Build OneCloud ImmortalWrt"
   - 点击右侧 "Run workflow"
   - 选择内核版本（建议 6.6）
   - 点击绿色的 "Run workflow" 按钮

4. **等待编译完成**（约 2-3 小时）

5. **下载固件**
   - 编译完成后进入 "Releases" 页面
   - 下载 `*_Flash.img.gz` 线刷固件

### 方法二：直接使用本仓库的 Releases

如果你不需要自定义配置，可以直接从本仓库的 [Releases](../../releases) 页面下载最新固件。

## 📥 刷机教程

### U盘启动刷机（推荐）

1. **下载固件**
   - 下载 `OneCloud_ImmortalWrt_XXXXXXXX_Kernel6.6_Flash.img.gz`
   - 解压得到 `.img` 文件

2. **制作启动盘**
   - 下载 [balenaEtcher](https://etcher.balena.io/)
   - 将 `.img` 文件写入 U盘（会清空 U盘数据）

3. **刷机步骤**
   ```
   ① OneCloud 断电
   ② 插入 U盘
   ③ 按住复位键不放
   ④ 给设备通电
   ⑤ 等待 LED 灯闪烁（约 5 秒）
   ⑥ 松开复位键
   ⑦ 系统自动安装到 eMMC（3-5 分钟）
   ⑧ 安装完成后拔掉 U盘
   ⑨ 重启设备
   ```

4. **首次登录**
   - 浏览器访问: `http://192.168.2.2`
   - 用户名: `root`
   - 密码: 无（直接回车）

### 线刷工具刷机

1. 下载 [USB Burning Tool](https://www.amlsetup.com/usb-burning-tool/)
2. OneCloud 进入线刷模式（短接主板触点）
3. 使用工具刷入 `.img` 文件

## ⚙️ 自定义配置

### 修改固件配置

如果你需要自定义固件内容，可以修改以下文件：

#### 1. `.config` - 编译配置

控制编译哪些软件包和功能。主要配置：
- 目标设备：OneCloud (Meson8b)
- 内核模块：USB、文件系统支持
- LuCI 应用：已包含常用插件

#### 2. `diy.sh` - 自定义脚本

用于修改默认配置或添加第三方插件：

```bash
# 修改默认 IP（已配置为 192.168.2.2）
sed -i 's/192.168.1.1/你的IP/g' package/base-files/files/bin/config_generate

# 添加第三方插件（取消注释即可使用）
# git clone --depth=1 https://github.com/xxx/插件名.git package/插件名
```

常用插件示例（在 `diy.sh` 中取消注释即可）：
- UA2F - 绕过校园网检测
- PassWall - 科学上网
- OpenClash - Clash 客户端
- AdGuard Home - 广告过滤
- iStore - 应用商店

### 修改网络配置

默认配置：
- IP: `192.168.2.2`
- 网关: `192.168.2.1`
- 子网掩码: `255.255.255.0`

如需修改，编辑 `diy.sh` 文件中的相关行。

## 🌐 默认网络配置

| 项目 | 值 |
|------|------|
| IP 地址 | 192.168.2.2 |
| 网关 | 192.168.2.1 |
| 子网掩码 | 255.255.255.0 |
| 用户名 | root |
| 密码 | 无（留空） |
| Web 管理 | http://192.168.2.2 |
| SSH 端口 | 22 |

## 📦 项目文件说明

```
Actions-ImmortalWrt-main/
├── .github/
│   └── workflows/
│       └── build.yml          # GitHub Actions 工作流配置
├── .config                    # OpenWrt 编译配置文件
├── diy.sh                     # 自定义脚本
├── .gitignore                 # Git 忽略文件
├── README.md                  # 项目说明文档
└── LICENSE                    # 开源协议
```

### 核心文件说明

- **build.yml**: GitHub Actions 自动构建脚本
  - 每月 1 号自动构建
  - 支持手动触发
  - 自动发布到 Releases
  - 只保留最新版本

- **.config**: OpenWrt 编译配置
  - 目标设备：OneCloud
  - 包含常用插件和功能
  - 优化存储和网络性能

- **diy.sh**: 自定义脚本
  - 修改默认 IP 为 192.168.2.2
  - 修改主机名为 OneCloud
  - 可添加第三方插件

## ⚠️ 注意事项

1. **刷机前请备份重要数据**，刷机会清空 eMMC 所有内容
2. **刷机过程中不要断电**，否则可能导致设备变砖
3. 首次启动需要 2-3 分钟，请耐心等待
4. 默认 IP 为 192.168.2.2，请确保电脑在同一网段

## 🆘 常见问题

### Q: 刷机后无法启动？
**A**: 检查是否完全写入，重新刷写一次。确保使用正确的 `.img` 文件。

### Q: 无法访问 192.168.2.2？
**A**: 
- 确保电脑 IP 在 192.168.2.x 网段
- 或者将 OneCloud 接入路由器，通过路由器 DHCP 获取 IP
- 检查网线是否连接正常

### Q: 忘记修改的密码？
**A**: 
- 重新刷机恢复默认设置
- 或进入 Failsafe 模式重置密码

### Q: 如何添加更多插件？
**A**: 
- 方法一：修改 `.config` 文件，添加对应的包
- 方法二：在 `diy.sh` 中添加 git clone 命令
- 方法三：刷机后在 LuCI 界面安装

### Q: 编译失败怎么办？
**A**: 
- 检查 Actions 运行日志
- 确认 `.config` 文件格式正确
- 查看是否是第三方插件导致的冲突

## 📅 更新日志

- 自动构建：每月 1 号北京时间 00:00
- Release 保留：仅保留最新版本
- Artifacts 保留：30 天

## 📄 开源协议

本项目基于 GPL-3.0 协议开源。

## 🙏 致谢

- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt) - 固件源码
- [P3TERX](https://github.com/P3TERX/Actions-OpenWrt) - Actions 脚本参考
- 所有第三方插件开发者

## 📞 支持

- 遇到问题？[提交 Issue](../../issues)
- 功能建议？[发起 Discussion](../../discussions)

---

⭐ 如果这个项目对你有帮助，请给个 Star 吧！
