# My Dotfile repo
use GNU `stow` for managing my dotfiles that I want to keep

arch + hyprland dotfiles very basic I know

## reqs
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
- qt6ct-kde

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
    - + Sweet GTK theme
- syncthing

## Environment Variables
> /etc/environment

- `ORCA_SSH_IP=<ip address>`
- `ORCA_SSH_PORT=<port number>`

## setting the theme with kvantum, qt6ct, and nwg-look

1. install both kvantum and qt6ct, then the theme and icons
    - [qt6ct-kde](https://aur.archlinux.org/packages/qt6ct-kde) sometimes fixes various issues
2. unzip the icons in `~/.icons` (or `/usr/share/.icons/` or `~/.local/share/.icons`)
    - theme can go anywhere, but I like to match icons
3. run kvantum, then install and apply the theme (it wont show until you set qt6ct as well)
4. use qt6ct to apply the `kvantum` theme, then the set the right icon theme as well

- this sets the theme for qt6 apps 
- to set the same theme for gtk apps, use nwg-look

1. set widget theme to Sweet-Gtk
2. set candy-icons in `Icon Theme`


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


## Screensharing discord
if app is using xwayland, like discord, use:
- [xwaylandvideobridge](https://aur.archlinux.org/packages/xwaylandvideobridge-git)
