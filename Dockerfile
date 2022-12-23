FROM m1k1o/neko:xfce

RUN apt update -y && apt install -y --no-install-recommends curl xz-utils firefox-esr vim-gtk3; \
    mkdir -p /home/neko/app; \
    chown -R neko:neko /home/neko/app; \

     # download TOR browser
    DOWNLOAD_URI="$(curl -s -N https://www.torproject.org/download/ | grep -Po -m 1 '(?=(dist/torbrowser)).*(?<=.tar.xz)')"; \
	echo "Downloading $DOWNLOAD_URI"; \
	curl -sSL -o /tmp/tor.tar.xz "https://www.torproject.org/$DOWNLOAD_URI"; \
    tar -xvJf /tmp/tor.tar.xz -C /home/neko/app; \
    chown -R neko:neko /home/neko/app/tor-browser; \
    rm -f /tmp/tor.tar.xz; \
    #cp /home/neko/tor-browser/start-tor-browser.desktop  /home/neko/.local/share/applications/start-tor-browser.desktop
    #cd /home/neko/tor-browser/ && ./start-tor-browser.desktop --register-app

    # create firefox profile directory
    mkdir -p /home/neko/.mozilla/firefox/profile.default; \
    chown -R neko:neko /home/neko/.mozilla
    
    #

COPY --chown=neko firefox/profiles.ini /home/neko/.mozilla/firefox/profiles.ini
#COPY --chown=neko firefox/times.json /home/neko/.mozilla/firefox/profile.default/times.json