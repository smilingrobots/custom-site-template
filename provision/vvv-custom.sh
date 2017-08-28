SOURCE_DIR="/srv/sources/$SITE"

if [ -d "$SOURCE_DIR" ]; then
    SRC_WP_PLUGINS=`cat ${VVV_CONFIG} | shyaml get-values sites.${SITE_ESCAPED}.custom.source_dir_wp_plugins 2> /dev/null`

    for p in $SRC_WP_PLUGINS; do
        BASE_NAME=`basename $p`
        LINK_DEST="$VVV_PATH_TO_SITE/public_html/wp-content/plugins/$BASE_NAME"

        if [ -L "$LINK_DEST" ]; then
            rm -f "$LINK_DEST"
        fi

        if [ ! -e "$LINK_DEST" ]; then
            ln -s "$SOURCE_DIR/$p" "$LINK_DEST"
        fi
    done
fi
