# apt-get waits indefinitely on a mirror that keeps trickling data, so each network step is
# bounded and retried; partial downloads stay in apt's cache, so a retry resumes them.
# Installation itself is never interrupted, which could leave dpkg half-configured.
readonly APT_ATTEMPTS=3
readonly APT_TIMEOUT_SECONDS=600

apt_retry() {
    local attempt
    for attempt in $(seq "$APT_ATTEMPTS"); do
        if sudo timeout "$APT_TIMEOUT_SECONDS" apt-get "$@"; then
            return 0
        fi
        echo "apt-get $* failed (attempt $attempt of $APT_ATTEMPTS)" >&2
    done
    return 1
}

apt_update() {
    apt_retry update
}

apt_install() {
    apt_retry install -y --download-only "$@" || return
    sudo apt-get install -y "$@"
}
