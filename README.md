# Organize Folder

A macOS utility that sorts messy folders by file extension into clean, categorized subfolders — with a visual preview before anything moves.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-support-yellow?logo=buymeacoffee)](https://buymeacoffee.com/anjanj)

<!-- ![Preview](screenshots/preview.png) -->

## Features

- **90+ file extensions** sorted into 15 categories
- **Visual HTML preview** in your browser before any files move
- **Native macOS app** — double-click, pick a folder, done
- **CLI mode** with `--dry-run` support
- **Idempotent** — safe to run multiple times, never double-nests files
- **Handles collisions** — duplicate filenames get `_1`, `_2` suffixes
- **Recursive** — organizes each subfolder independently
- **No dependencies** — just zsh (default on macOS)

## Install

```bash
git clone https://github.com/AnjanJ/organize-folder.git
cd organize-folder
./install.sh
```

This installs:
- **App** at `~/Applications/Organize Folder.app` (drag to Dock for quick access)
- **CLI** at `~/.local/bin/organize-folder`

## Usage

### As an App

1. Double-click **Organize Folder** in `~/Applications` (or from Dock)
2. Pick a folder
3. Browser opens with a preview — scroll through, review what will move
4. Click **Organize** in the confirmation dialog
5. Done — pick another folder or quit

If the folder is already organized, it tells you so.

### From the Terminal

```bash
# Organize a folder
organize-folder ~/Downloads

# Preview without moving anything
organize-folder ~/Desktop --dry-run

# Show help
organize-folder --help
```

## Categories

| Category | Extensions |
|----------|-----------|
| **images** | jpg, jpeg, png, gif, svg, webp, ico, bmp, tiff, heic |
| **docs** | pdf, doc, docx, txt, rtf, odt, pages |
| **spreadsheets** | xls, xlsx, csv, numbers, ods, tsv |
| **presentations** | ppt, pptx, key, odp |
| **archives** | zip, tar, gz, bz2, 7z, rar, xz, tgz |
| **audio** | mp3, wav, flac, aac, ogg, m4a, wma |
| **video** | mp4, mov, avi, mkv, wmv, webm, m4v, flv |
| **code** | rb, py, js, ts, jsx, tsx, html, css, json, yml, xml, sh, md, sql, rs, go, java, c, cpp, swift, kt, ex, exs, and more |
| **installers** | dmg, pkg, app, exe, msi, deb, rpm |
| **fonts** | ttf, otf, woff, woff2 |
| **design** | psd, ai, sketch, fig, xd, indd |
| **data** | sqlite, db, dbf |
| **ebooks** | epub, mobi, azw3 |
| **logs** | log |
| **other** | anything not listed above |

## How It Works

```
Before:                          After:
~/Downloads/                     ~/Downloads/
  report.pdf                       docs/
  photo.jpg                          report.pdf
  script.rb                        images/
  old-stuff/                         photo.jpg
    notes.txt                      code/
    pic.png                          script.rb
                                   old-stuff/        <- stays as a folder
                                     docs/
                                       notes.txt
                                     images/
                                       pic.png
```

Each subfolder is organized independently — files stay within their original folder, just sorted into categories.

**Idempotent by design:** Running it again on an already-organized folder moves zero files. It skips:
- Files already inside the correct category folder
- Category folders themselves (never recurses into `images/`, `docs/`, etc.)
- Hidden files and in-progress downloads (`.crdownload`, `.part`)

## Uninstall

```bash
cd organize-folder
./uninstall.sh
```

## Requirements

- macOS (uses zsh, which is the default shell since Catalina)
- No other dependencies

## Contributing

Issues and PRs welcome. If you have ideas for new categories, better extension mappings, or UI improvements — open an issue.

## License

[MIT](LICENSE)

---

If this tool saved you time, consider buying me a coffee:

<a href="https://www.buymeacoffee.com/anjanj" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="200"></a>
