#!/bin/bash
#Post Hook: default
function __sdkman_post_installation_hook {
    __sdkman_echo_debug "No Linux post-install hook found for Gradle 4.7."
    __sdkman_echo_debug "Moving $binary_input to $zip_output"
    mv "$binary_input" "$zip_output"
}