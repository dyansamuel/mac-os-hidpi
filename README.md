# CFORCE HiDPI for macOS

一个给 macOS 外接 `CFORCE 2560x1600` 便携屏添加更多 HiDPI 缩放分辨率的本地工具。

这是一个针对本机 `CFORCE` 外接屏的小工具。目标屏幕信息：

- 名称：`CFORCE`
- 原生分辨率：`2560x1600`
- VendorID：`0x4a8b`
- ProductID：`0xcf`

工具参考了 [xzhih/one-key-hidpi](https://github.com/xzhih/one-key-hidpi) 的方式：在 macOS 的显示器 override 目录写入 `scale-resolutions`，让系统设置里的显示器缩放列表出现更多 HiDPI 选项。

## 功能

- 自动识别 `CFORCE` 显示器，避免误改其他屏幕
- 新增 `1600x1000`、`2048x1280` 等 16:10 HiDPI 档位
- 支持双击 `.app` 安装，也支持命令行安装/卸载
- 安装前自动备份已有 override
- 如果系统里已有 CFORCE override，会合并旧分辨率并去重

## 默认新增的 HiDPI 档位

- `2048x1280`
- `1920x1200`
- `1800x1125`
- `1680x1050`
- `1600x1000`
- `1440x900`
- `1280x800`

其中 `1600x1000` 和 `2048x1280` 是你明确提到的两个档位。

## 已验证环境

- macOS 26.5.1
- Apple Silicon Mac，M4 Max
- CFORCE 外接便携屏，原生分辨率 `2560x1600`
- 已实测 `1600x1000` 可以成功开启 HiDPI

## 推荐用法：双击 App

先构建本地 App：

```bash
./scripts/build-app
```

然后双击：

```text
CFORCE HiDPI.app
```

它会打开 Terminal 并执行安装脚本；按提示输入 macOS 管理员密码即可。安装完成后重启 macOS，再进入：

```text
System Settings > Displays
```

选择 CFORCE 屏幕，在缩放分辨率中选择新的 HiDPI 档位。如果列表没有全部展开，可以按住 `Option` 再点缩放选项，或打开显示所有分辨率。

## 命令行用法

列出显示器：

```bash
./bin/cforce-hidpi list
```

查看当前状态：

```bash
./bin/cforce-hidpi status
```

生成本地 plist，先不安装：

```bash
./bin/cforce-hidpi generate
```

安装默认分辨率：

```bash
./bin/cforce-hidpi install
```

只安装指定分辨率：

```bash
./bin/cforce-hidpi install --resolutions 1600x1000,2048x1280
```

卸载：

```bash
./bin/cforce-hidpi uninstall
```

## 写入位置

安装后会生成：

```text
/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-4a8b/DisplayProductID-cf
```

如果已有同名 override 文件，脚本会先备份为：

```text
DisplayProductID-cf.backup-YYYYMMDD-HHMMSS
```

安装时会合并已有的 `scale-resolutions` 和新的 16:10 档位，避免覆盖掉你已经存在的 CFORCE 分辨率配置。

## 备注

- 安装后需要重启，显示器设置才会稳定刷新。
- 这个工具默认只匹配 `CFORCE`，不会改另一台 `Sculptor`。
- `2048x1280` 对 2560x1600 屏幕来说属于更高的缩放渲染模式，如果系统不显示这个档位，通常是 macOS 或链路带宽/显示器 EDID 限制；可以先用 `1600x1000`、`1680x1050`、`1920x1200`。

## License

MIT
