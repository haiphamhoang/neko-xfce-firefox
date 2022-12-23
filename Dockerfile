FROM m1k1o/neko:xfce

RUN apt update -y && apt install firefox-esr -y; \
    apt-get install -y --no-install-recommends curl xz-utils; \
    # create a profile directory
    mkdir -p /home/neko/.mozilla/firefox/profile.default/extensions; \
    chown -R neko:neko /home/neko/.mozilla/firefox/profile.default; \

     # download TOR browser
    DOWNLOAD_URI="$(curl -s -N https://www.torproject.org/download/ | grep -Po -m 1 '(?=(dist/torbrowser)).*(?<=.tar.xz)')"; \
	echo "Downloading $DOWNLOAD_URI"; \
	curl -sSL -o /tmp/tor.tar.xz "https://www.torproject.org/$DOWNLOAD_URI"; \
    tar -xvJf /tmp/tor.tar.xz -C /opt; \
    mv /opt/tor-browser* /opt/tor-browser_All; \
    chown -R neko:neko /opt/tor-browser_All/; \
    rm -f /tmp/tor.tar.xz; \
    #

COPY --chown=neko profiles.ini /home/neko/.mozilla/firefox/profiles.ini