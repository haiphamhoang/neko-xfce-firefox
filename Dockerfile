FROM m1k1o/neko:xfce

RUN apt update -y && apt install -y --no-install-recommends curl xz-utils firefox-esr vim-gtk3; \
    mkdir -p /home/neko/app; \
    chown -R neko:neko /home/neko/app; \

    # create firefox profile directory
    mkdir -p /home/neko/.mozilla/firefox/profile.default; \
    chown -R neko:neko /home/neko/.mozilla; \

    # clean up
    apt-get clean -y; \
    rm -rf /var/cache/apt/*

COPY --chown=neko firefox/profiles.ini /home/neko/.mozilla/firefox/profiles.ini