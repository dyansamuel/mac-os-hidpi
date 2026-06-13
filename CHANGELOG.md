# Changelog

## v1.1.0 - 2026-06-13

### Added

- Adds interactive display selection when multiple displays are connected.
- Adds `--display-index` for selecting a display from `macos-hidpi list`.
- Adds aspect-ratio-aware default HiDPI mode presets for 16:10, 16:9, 3:2, 4:3, and 21:9 displays.
- Adds `bin/macos-hidpi` as the generic command-line entry point.

### Changed

- Renames the generated app from `CFORCE HiDPI.app` to `macOS HiDPI.app`.
- Keeps `bin/cforce-hidpi` as a compatibility wrapper.
- Updates documentation to describe the project as a general macOS HiDPI tool instead of a CFORCE-only utility.

## v1.0.0 - 2026-06-13

Initial public release of CFORCE HiDPI for macOS.

### Added

- Detects the `CFORCE` external display by display product name.
- Adds 16:10 HiDPI scaled modes for `2560x1600` CFORCE panels:
  - `2048x1280`
  - `1920x1200`
  - `1800x1125`
  - `1680x1050`
  - `1600x1000`
  - `1440x900`
  - `1280x800`
- Provides both a command-line installer and a locally buildable macOS `.app` wrapper.
- Backs up existing display override files before installing.
- Merges existing `scale-resolutions` entries instead of replacing them.
- Supports uninstalling the generated display override.

### Verified

- Tested on macOS 26.5.1 with an Apple Silicon M4 Max Mac.
- Tested with a `CFORCE` external display at native `2560x1600`.
- Confirmed `1600x1000` works as a HiDPI scaled resolution.
