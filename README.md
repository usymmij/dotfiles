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

## References

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
- Sweet KDE theme
- kvantum
- qt6ct
- syncthing

## Settings
> /etc/environment

`QT_QPA_PLATFORMTHEME=qt6ct`
`ORCA_SSH_IP=<ip address>`
`ORCA_SSH_PORT=<port number>`

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
- ![here](https://www.dafont.com/valorant.font)

