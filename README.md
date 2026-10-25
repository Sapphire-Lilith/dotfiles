# Setup Instructions

## 1. Prerequisites

### Ubuntu

```sh
sudo apt update && sudo apt install -y curl git
```

### macOS

```sh
xcode-select --install
```

## 2. Install

```sh
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply Sapphire-Lilith
```

Without interactive prompts:

```sh
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply \
  --promptString name=<user.name> --promptString email=<user.email> Sapphire-Lilith
```

> replace `<user.name>` & `<user.email>` with your GitHub username and email address.

### Japanese input (Ubuntu)

After the first install, log out and back in (or reboot) so fcitx5 starts, then add Mozc in
Fcitx 5 Configuration. Discord and Slack (snap) pick it up through fcitx5.

### Switch to SSH remote

```sh
chezmoi git -- remote set-url origin git@github.com:Sapphire-Lilith/dotfiles.git
```

## 3. Update

```sh
chezmoi update --apply=false
chezmoi diff
chezmoi apply
```

## Theme

### Firefox

[theme](https://color.firefox.com/?theme=XQAAAAIPAQAAAAAAAABBKYhm849SCia2CaaEGccwS-xMDPr79BBH6_4EviDIjBgjl6kvKSCXiFw5UxNt9OSQawug33IeDJ2AqkLtmql401QYZJfnyoZQoKnAAMLlMeN9ZURG73RRFNimO--nJVRIjsH6hZ2ZJD85mfat4KZlvW4f6nyeW32C4GJyrfh2fP2BiOmGPk_nvQy3tKWUOAEac7TiePOQXc0X9V7ouCRd_YD-Pg)

### DuckDuckGo

theme: sapphire_dark
