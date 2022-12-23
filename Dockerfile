FROM m1k1o/neko:xfce

RUN apt update -y && apt install firefox-esr -y; \
    apt-get install -y --no-install-recommends curl xz-utils; \
    # create a profile directory
    mkdir -p /home/neko/.mozilla/firefox/profile.default/extensions; \
    chown -R neko:neko /home/neko/.mozilla; \

     # download TOR browser
    DOWNLOAD_URI="$(curl -s -N https://www.torproject.org/download/ | grep -Po -m 1 '(?=(dist/torbrowser)).*(?<=.tar.xz)')"; \
	echo "Downloading $DOWNLOAD_URI"; \
	curl -sSL -o /tmp/tor.tar.xz "https://www.torproject.org/$DOWNLOAD_URI"; \
    tar -xvJf /tmp/tor.tar.xz -C /home/neko/app; \
    chown -R neko:neko /home/neko/app/tor-browser/; \
    rm -f /tmp/tor.tar.xz
    #cp /home/neko/tor-browser/start-tor-browser.desktop  /home/neko/.local/share/applications/start-tor-browser.desktop
    #cd /home/neko/tor-browser/ && ./start-tor-browser.desktop --register-app
    
    #

COPY --chown=neko firefox/profiles.ini /home/neko/.mozilla/firefox/profiles.ini