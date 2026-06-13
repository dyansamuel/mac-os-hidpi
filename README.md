# macOS HiDPI

[中文](#中文) | [English](#english)

## 中文

一个给 macOS 外接显示器添加更多 HiDPI 缩放分辨率的本地工具。

工具参考了 [xzhih/one-key-hidpi](https://github.com/xzhih/one-key-hidpi) 的方式：在 macOS 的显示器 override 目录写入 `scale-resolutions`，让系统设置里的显示器缩放列表出现更多 HiDPI 选项。

这个项目最初为 `CFORCE 2560x1600` 便携屏制作，现在已经改成可选择任意已连接显示器。

### 功能

- 列出当前连接的显示器，并让用户选择要配置的屏幕
- 支持按显示器编号、产品名、VendorID/ProductID 指定目标
- 根据所选显示器的原生比例推导默认 HiDPI 档位
- 支持用 `--resolutions` 自定义 HiDPI 分辨率
- 支持双击 `.app` 安装，也支持命令行安装/卸载
- 安装前自动备份已有 override
- 如果系统里已有 override，会合并旧分辨率并去重

### 默认新增的 HiDPI 档位

工具会根据所选显示器的原生宽高比选择一组默认档位。

例如 `2560x1600` / 16:10 显示器会默认添加：

- `2048x1280`
- `1920x1200`
- `1800x1125`
- `1680x1050`
- `1600x1000`
- `1440x900`
- `1280x800`

16:9、3:2、4:3、21:9 显示器会使用对应比例的默认档位。不合常见比例的显示器会按原生分辨率比例自动生成一组缩放档位。

### 已验证环境

- macOS 26.5.1
- Apple Silicon Mac，M4 Max
- CFORCE 外接便携屏，原生分辨率 `2560x1600`
- 已实测 `1600x1000` 可以成功开启 HiDPI

### 推荐用法：双击 App

先构建本地 App：

```bash
./scripts/build-app
```

然后双击：

```text
macOS HiDPI.app
```

它会打开 Terminal，列出已连接显示器，并让你输入要配置的显示器编号。按提示输入 macOS 管理员密码即可。安装完成后重启 macOS，再进入：

```text
System Settings > Displays
```

选择目标屏幕，在缩放分辨率中选择新的 HiDPI 档位。如果列表没有全部展开，可以按住 `Option` 再点缩放选项，或打开显示所有分辨率。

### 命令行用法

列出显示器：

```bash
./bin/macos-hidpi list
```

查看当前状态：

```bash
./bin/macos-hidpi status --display-index 3
```

生成本地 plist，先不安装：

```bash
./bin/macos-hidpi generate --display-index 3
```

交互式安装默认分辨率：

```bash
./bin/macos-hidpi install
```

按显示器编号安装默认分辨率：

```bash
./bin/macos-hidpi install --display-index 3
```

只安装指定分辨率：

```bash
./bin/macos-hidpi install --display-index 3 --resolutions 1600x1000,2048x1280
```

卸载：

```bash
./bin/macos-hidpi uninstall --display-index 3
```

### 写入位置

安装后会按所选显示器的 VendorID/ProductID 生成 override 文件，例如 CFORCE 的路径是：

```text
/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-4a8b/DisplayProductID-cf
```

如果已有同名 override 文件，脚本会先备份为：

```text
DisplayProductID-cf.backup-YYYYMMDD-HHMMSS
```

安装时会合并已有的 `scale-resolutions` 和新的 HiDPI 档位，避免覆盖掉你已经存在的显示器分辨率配置。

### 备注

- 安装后需要重启，显示器设置才会稳定刷新。
- 请先运行 `./bin/macos-hidpi list` 确认目标显示器编号。
- 某些高于原生分辨率比例的缩放渲染模式可能受 macOS、链路带宽或显示器 EDID 限制；如果系统不显示某个档位，可以先尝试更保守的分辨率。
- 旧命令 `./bin/cforce-hidpi` 仍保留为兼容入口，内部会转到 `./bin/macos-hidpi`。

## English

A local macOS utility for adding more HiDPI scaled resolutions to external displays.

This tool follows the same general approach as [xzhih/one-key-hidpi](https://github.com/xzhih/one-key-hidpi): it writes display override files with `scale-resolutions`, so macOS can expose additional scaled HiDPI modes in Display Settings.

The project started as a fix for a `CFORCE 2560x1600` portable display, and now supports selecting any connected display.

### Features

- Lists connected displays and lets the user choose which display to configure
- Supports selecting a display by index, product name, or VendorID/ProductID
- Infers default HiDPI presets from the selected display's native aspect ratio
- Supports custom HiDPI modes with `--resolutions`
- Supports both a locally built `.app` wrapper and command-line install/uninstall
- Backs up existing display override files before installing
- Merges existing override resolutions and removes duplicates

### Default HiDPI Modes

The tool picks default modes based on the selected display's native aspect ratio.

For example, a `2560x1600` / 16:10 display defaults to:

- `2048x1280`
- `1920x1200`
- `1800x1125`
- `1680x1050`
- `1600x1000`
- `1440x900`
- `1280x800`

16:9, 3:2, 4:3, and 21:9 displays use matching preset groups. Displays with uncommon aspect ratios get a generated set based on the native resolution.

### Verified Setup

- macOS 26.5.1
- Apple Silicon Mac, M4 Max
- CFORCE external portable display, native `2560x1600`
- Confirmed `1600x1000` works as a HiDPI scaled mode

### Recommended Usage: Double-Click App

Build the local app first:

```bash
./scripts/build-app
```

Then double-click:

```text
macOS HiDPI.app
```

The app opens Terminal, lists connected displays, and asks for the display index to configure. Enter your macOS administrator password when prompted. After installation, restart macOS and open:

```text
System Settings > Displays
```

Select the target display and choose one of the new scaled HiDPI modes. If macOS does not show all modes, hold `Option` while opening scaled options, or enable showing all resolutions.

### Command-Line Usage

List displays:

```bash
./bin/macos-hidpi list
```

Check status:

```bash
./bin/macos-hidpi status --display-index 3
```

Generate a local plist without installing:

```bash
./bin/macos-hidpi generate --display-index 3
```

Install default modes interactively:

```bash
./bin/macos-hidpi install
```

Install default modes by display index:

```bash
./bin/macos-hidpi install --display-index 3
```

Install custom modes only:

```bash
./bin/macos-hidpi install --display-index 3 --resolutions 1600x1000,2048x1280
```

Uninstall:

```bash
./bin/macos-hidpi uninstall --display-index 3
```

### Override Location

The tool writes override files by VendorID/ProductID. For example, the CFORCE path is:

```text
/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-4a8b/DisplayProductID-cf
```

If an override file already exists, it is backed up as:

```text
DisplayProductID-cf.backup-YYYYMMDD-HHMMSS
```

During installation, existing `scale-resolutions` entries are merged with the new HiDPI modes, so existing display configuration is not discarded.

### Notes

- Restart macOS after installation so Display Settings refreshes reliably.
- Run `./bin/macos-hidpi list` first to confirm the target display index.
- Some scaled render modes above native resolution may be limited by macOS, link bandwidth, or display EDID. If a mode does not appear, try a more conservative resolution.
- The old `./bin/cforce-hidpi` command remains as a compatibility wrapper around `./bin/macos-hidpi`.

## License

MIT
