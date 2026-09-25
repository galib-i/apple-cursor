# Apple Cursor

Open source macOS Cursors (with themed hands) for `Windows` and `Linux` with _HiDPI Support_.

<p align="center">
  <img width="49%" alt="Mac macOS cursors" src="https://github.com/user-attachments/assets/75237d3f-0e16-40ca-8791-d0334395736f" />
  <img width="49%" alt="Windows macOS cursors" src="https://github.com/user-attachments/assets/87b9ae21-4f72-4a9d-9f84-990a267f589a" />
</p>

> [!NOTE]
> This is a fork of [ful1e5/apple_cursor](https://github.com/ful1e5/apple_cursor).
> All cursor SVG files are found in the [svg](./svg) directory and the original ones are also on [Figma](https://www.figma.com/file/OZw8Ylb9xPFw9h1uZYSMFa/apple_cursor?type=design&node-id=73%3A2&mode=design&t=dLILPgJJrLKeAcTE-1).

## Get Started

Download the latest release from [Releases](https://github.com/galib-i/apple-cursor/releases).

### Linux/X11

To install:

```bash
tar -xvf macOS.tar.xz                      # extract `.tar.xz`

# Install to local users
mkdir -p ~/.icons
mv macOS macOS-White ~/.icons/

# OR Install to all users
sudo mv macOS macOS-White /usr/share/icons/
```

To uninstall:

```bash
rm -rf ~/.icons/macOS*                     # Remove from local users
sudo rm -rf /usr/share/icons/macOS*        # Remove from all users
```

### Windows

To install:

1. Extract the downloaded `.zip` file.
2. Open the extracted directory and choose your preferred size folder (e.g., `macOS-Regular-Windows`).
3. Right-click `install.inf` and click _Install_.
4. Open `Control Panel > Personalisation and Appearance > Change mouse pointers`, select the new scheme and _Apply_.

To uninstall, run `uninstall.bat`, or navigate through the Registry Editor: `HKEY_CURRENT_USER > Control Panel > Cursors > Schemes` and right-clicking the style to uninstall.

## Development

To build and run this project from source, you will need:

- Python 3.8 or higher
- [uv](https://github.com/astral-sh/uv) (recommended) or pip
- [clickgen](https://github.com/ful1e5/clickgen) >= 2.2.2
- [resvg-py](https://pypi.org/project/resvg-py/)

```bash
git clone https://github.com/galib-i/apple-cursor
cd apple-cursor
uv pip install clickgen resvg-py
bash build.sh
```

Create custom themes (found in the `themes` directory) by:

1. Rendering SVG files to PNG files (via `render.py`).
2. Building cursor themes from PNG files (via `ctgen`).

<details>
<summary><b>Customise colours</b></summary>

Colours are defined in [`render.json`](./render.json). The SVGs use placeholder colours that get swapped at build time:

- `#00FF00` (green) → **Base colour** (the cursor fill)
- `#0000FF` (blue) → **Outline colour** (the cursor border)

To create a custom colour theme, add a new entry to `render.json`:

```json
{
  "macOS-Custom": {
    "dir": "svg",
    "out": "bitmaps/macOS-Custom",
    "colours": [
      { "match": "#00FF00", "replace": "#YOUR_BASE_HEX" },
      { "match": "#0000FF", "replace": "#YOUR_OUTLINE_HEX" }
    ]
  }
}
```

Then run:

```bash
python render.py
```

</details>

<details>
<summary><b>Customise Windows cursor size</b></summary>

To build Windows cursor with size `16`:

```bash
ctgen configs/win_rg.build.toml -s 16 -p windows -d "bitmaps/macOS" -n "macOS" -c "macOS Cursors with size 16"
```

You can also customise the output directory with `-o` option:

```bash
ctgen configs/win_rg.build.toml -s 16 -p windows -d "bitmaps/macOS" -o "out" -n "macOS" -c "macOS Cursors with size 16"
```

</details>

<details>
<summary><b>Customise XCursor size</b></summary>

To build XCursor with size `16`:

```bash
ctgen configs/x.build.toml -s 16 -p x11 -d "bitmaps/macOS" -n "macOS" -c "macOS XCursors with size 16"
```

You can also assign multiple sizes to `ctgen` for XCursors build:

```bash
ctgen configs/x.build.toml -s 16 24 32 -p x11 -d "bitmaps/macOS" -n "macOS" -c "Custom Sizes macOS XCursors"
```

</details>

<details>
<summary><b>Example</b></summary>

Generate a macOS cursor with green and black colours. First, add to `render.json`:

```json
{
  "macOS-Hacker": {
    "dir": "svg",
    "out": "bitmaps/macOS-Hacker",
    "colours": [
      { "match": "#00FF00", "replace": "#00FE00" },
      { "match": "#0000FF", "replace": "#000000" }
    ]
  }
}
```

Then render and build:

```bash
python render.py
ctgen configs/x.build.toml -d "bitmaps/macOS-Hacker" -n "macOS-Hacker" -c "Green and Black macOS cursors."
```

</details>

## Cursor Sizes

### Xcursor:

<kbd>16</kbd>
<kbd>20</kbd>
<kbd>22</kbd>
<kbd>24</kbd>
<kbd>28</kbd>
<kbd>32</kbd>
<kbd>40</kbd>
<kbd>48</kbd>
<kbd>56</kbd>
<kbd>64</kbd>
<kbd>72</kbd>
<kbd>80</kbd>
<kbd>88</kbd>
<kbd>96</kbd>

### Windows:

| size | Regular (× ²⁄₃) | Large (× ⁴⁄₅) | Extra-Large (× 1) |
| ---: | --------------: | ------------: | ----------------: |
|   32 |     21.333 → 22 |     25.6 → 26 |                32 |
|   48 |              32 |     38.4 → 39 |                48 |
|   64 |     42.666 → 43 |     51.2 → 52 |                64 |
|   96 |              64 |     76.8 → 77 |                96 |
|  128 |     85.333 → 86 |   102.4 → 103 |               128 |
|  256 |   170.666 → 171 |   204.8 → 205 |               256 |

## Colours

| Theme       | Base Colour       | Outline Colour    |
| ----------- | ----------------- | ----------------- |
| **Default** | `#000000` (Black) | `#FFFFFF` (White) |
| **White**   | `#FFFFFF` (White) | `#000000` (Black) |
