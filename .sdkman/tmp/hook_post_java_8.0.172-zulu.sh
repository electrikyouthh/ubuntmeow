#!/bin/bash
#Post Hook: linux-java-tarball
function __sdkman_post_installation_hook {
    __sdkman_echo_debug "A Linux post-install hook was found for Java 8.0.172-zulu."

    __sdkman_validate_binary_input "$binary_input" || return 1

    local present_dir="$(pwd)"
    local work_dir="${SDKMAN_DIR}/tmp/out"
    local cookie_file="${SDKMAN_DIR}/var/cookie"

    echo ""
    echo "Repackaging Java 8.0.172-zulu..."

    mkdir -p "$work_dir"
    /usr/bin/env tar zxf "$binary_input" -C "$work_dir"

    cd "$work_dir"
    /usr/bin/env zip -qyr "$zip_output" .
    cd "$present_dir"

    echo ""
    echo "Done repackaging..."

    __sdkman_echo_debug "Cleaning up cookie if present..."
    if [ -f "$cookie_file" ] ; then rm "$cookie_file"; fi

    __sdkman_echo_debug "Cleaning up residual files..."
    rm "$binary_input"
    rm -rf "$work_dir"
}

function __sdkman_validate_binary_input {
    if ! tar tzf "$1" &> /dev/null; then
        echo "Download has failed, aborting!"
        echo ""
        echo "Can not install java 8.0.172-zulu at this time..."
        return 1
    fi
}
