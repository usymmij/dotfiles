sudo grep -v "Exec=" /opt/discord/discord.desktop > tmpfile && mv tmpfile /opt/discord/discord.desktop

sudo echo "Exec=/usr/bin/discord --disable-gpu">> /opt/discord/discord.desktop
