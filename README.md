# My Dotfile repo
use GNU `stow` for managing my dotfiles that I want to keep

## apps managed
- bash
- neovim
- kitty
- spicetify
- starship
- hyprland
    - hyprlock
- hyprshot 
- waybar
- qutebrowser
- mako
- swww
- kvantum
- qt6ct


# Additional info / instructions for new systems
- sometimes I forget, so this is a nice step by step for when I install. Maybe I should start my own distro instead... (jk)

## Reference Material
> nice video about stow [link](https://www.youtube.com/watch?v=y6XCebnB9gs&ab_channel=DreamsofAutonomy)

> many configs are modified or directly from SolDoesTech's [HyprV2](https://github.com/SolDoesTech/HyprV2)

## Spicetify
- under `.config/spicetify/Themes`, make sure to install [spicetify-themes](https://github.com/spicetify/spicetify-themes)
- make sure that the themes are in the `Themes` folder, not the new one git created
- you can use the following commands
```bash
cd ~/.config/spicetify/Themes
git clone https://github.com/spicetify/spicetify-themes .
```

## ssh client alias
- to use the ssh orca alias, add `ORCA_SSH_IP=<ip address>` and `ORCA_SSH_PORT="<port number>"` to `/etc/environment`
- then, generate a new ssh key, and store it as `~/.ssh/orca` 
  - add `orca.pub` to `~/.ssh/authorized_keys` on the target server

# some useful things for myself

## other packages
> just a list of packages I like
- fastfetch 
- openssh
- spotify
- discord
- sbctl (when secure boot is needed)
- candy-icons
- Sweet KDE theme (Kvantum)
- syncthing

## Environment Variables
> /etc/environment

- `QT_QPA_PLATFORMTHEME=qt6ct`
- `QT_QPA_PLATFORM=wayland`
- `ORCA_SSH_IP=<ip address>`
- `ORCA_SSH_PORT=<port number>`

## setting the theme with kvantum and qt6ct

1. install both kvantum and qt6ct, then the theme and icons
2. unzip the icons in `~/.icons` (or `/usr/share/.icons/` or `~/.local/share/.icons`)
    - theme can go anywhere, but I like to match icons
3. run kvantum, then install and apply the theme (it wont show until you set qt6ct as well)
4. use qt6ct to apply the `kvantum` theme, then the set the right icon theme as well

## adding syncthing with a cronjob
- remember to enable the cron daemon if not already

```
$ chmod +x ~/.scripts/sync.sh
$ crontab -e
@reboot ~/.scripts/sync.sh
```

## ignoring system specific changes in git

```bash
# removing a file
git update-index --assume-unchanged file_name

# adding a file back
git update-index --no-assume-unchanged file_name 
```

## font for hyprlock
- need font
- [here](https://www.dafont.com/valorant.font)

