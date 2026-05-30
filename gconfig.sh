#!/bin/bash

gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:maximize,minimize,close'
gsettings set org.gnome.desktop.wm.preferences action-right-click-titlebar 'lower'
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true
gsettings set org.gnome.nautilus.preferences always-use-location-entry true
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false
gsettings set org.gnome.desktop.interface enable-hot-corners true
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
gsettings set org.gnome.shell always-show-log-out true

# Flatpak installs
flatpak info org.gnome.gedit >/dev/null 2>&1 || flatpak install -y flathub org.gnome.gedit
flatpak info com.brave.Browser >/dev/null 2>&1 || flatpak install -y flathub com.brave.Browser
flatpak info io.github.dvlv.boxbuddyrs >/dev/null 2>&1 || flatpak install -y flathub io.github.dvlv.boxbuddyrs
flatpak info io.github.debasish_patra_1987.linuxthemestore >/dev/null 2>&1 || flatpak install -y flathub io.github.debasish_patra_1987.linuxthemestore
flatpak info best.ellie.StartupConfiguration >/dev/null 2>&1 || flatpak install -y flathub best.ellie.StartupConfiguration


# Add apps to dock favorites in one command to avoid overwriting
gsettings set org.gnome.shell favorite-apps "$(python3 -c '
import json, sys
favs = json.loads(sys.stdin.read())
new = [
    "gnome-calculator.desktop",
    "org.gnome.gedit.desktop",
    "io.github.debasish_patra_1987.linuxthemestore.desktop",
    "com.brave.Browser.desktop",
    "best.ellie.StartupConfiguration.desktop",
    "io.github.dvlv.boxbuddyrs.desktop"
]
for app in new:
    if app not in favs:
        favs.append(app)
print(json.dumps(favs))
' <<< "$(gsettings get org.gnome.shell favorite-apps | sed "s/'/\"/g")")"

# Symlink wallpapers to backgrounds for Linux Theme Store
mkdir -p ~/.local/share/backgrounds
if [ -L ~/.local/share/wallpapers ]; then
    rm ~/.local/share/wallpapers
fi
ln -s ~/.local/share/backgrounds ~/.local/share/wallpapers
