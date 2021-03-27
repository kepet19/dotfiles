#!/usr/bin/env bash

# NOTE:
# This doesn't work as is on Windows. You'll need to create an equivalent `.bat` file instead
#
# NOTE:
# If you're not using Linux you'll need to adjust the `-configuration` option
# to point to the `config_mac' or `config_win` folders depending on your system.

# copy the configuration folder to tmp to be writable
tmp_dir="$(mktemp -d /tmp/jdtls.XXXXX)"
cp -R /usr/share/java/jdtls/config_linux "${tmp_dir}"
# and ensure that it is removed on exit
trap "{ rm -rf ${tmp_dir}; }" EXIT

GRADLE_HOME=$HOME/DEV/gradle /usr/lib/jvm/java-15-openjdk/bin/java\
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -Dlog.protocol=true \
    -Dlog.level=ALL \
    -Xms1g \
    -Xmx2G \
    -jar /usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar \
    -configuration "${tmp_dir}/config_linux" \
    -data "${1:-$HOME/DEV/workspace}" \
    --add-modules=ALL-SYSTEM \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.lang=ALL-UNNAMED
    "$@"
