# My Dotfile repo
use GNU `stow` for managing my dotfiles that I want to keep

arch + hyprland dotfiles very cliche I know

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

# References

## gnu stow
> nice video about stow [link](https://www.youtube.com/watch?v=y6XCebnB9gs&ab_channel=DreamsofAutonomy)

## hyprland
> many configs are modified or directly from SolDoesTech's [HyprV2](https://github.com/SolDoesTech/HyprV2)

> also [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) 

## Updating submodules
`git submodule update --recursive`

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

# secure boot configuration
- [sbctl](https://github.com/Foxboron/sbctl)

## Theme
- candy-icons
- Sweet KDE theme (Kvantum)
    - + Sweet GTK theme

## Environment Variables
> /etc/environment

- `ORCA_SSH_IP=<ip address>`
- `ORCA_SSH_PORT=<port number>`

## pairing the same bluetooth device to both windows + linux when dual booting
[read this](https://unix.stackexchange.com/questions/255509/bluetooth-pairing-on-dual-boot-of-windows-linux-mint-ubuntu-stop-having-to-p)

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

## ignoring system specific changes in git

```bash
# removing a file
git update-index --assume-unchanged file_name

# adding a file back
git update-index --no-assume-unchanged file_name 

# see what files are assumed unchanged
git ls-files -v | grep '^[[:lower:]]'
```

# Install Instructions
1. setup up a base arch install, 
    - recommended to have `efivars` and `systemdboot`
    - `networkmanager`
    - make a user account
2. install `yay`
```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```
3. install these packages with yay
> compositor and desktop
```
hyprland hypridle hyprlock hyprshot hyprpaper wofi kitty fastfetch waybar starship 
```
> fonts
```
noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-jetbrains-mono-nerd
```
> text and pdf
```
nvim fzf zaread zathura-pdf-poppler stylua clangd
```
> other tools
```
man stow stow
```
> customization
```
kvantum nwg-look
```
> optional apps
```
qutebrowser nextcloud-client rnote discord thunderbird
```

3. download dotfiles
```bash
cd ~
mkdir .config # Important for not adding undesireable dotfiles 
git clone https://github.com/usymmij/dotfiles
cd dotfiles
git submodule update --init
stow . --adopt
```
> make sure to also untrack these files
```bash
git update-index --assume-unchanged .config/cyclebackground/current_background 
git update-index --assume-unchanged .config/hypr/local.conf
```
