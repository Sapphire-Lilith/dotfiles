# Every download retries transient failures and gives up rather than hanging.
curl_opts=(-fsSL --retry 3 --retry-all-errors --connect-timeout 10 --max-time 300)
download_dir="$(mktemp -d)"
trap 'rm -rf "$download_dir"' EXIT

# Runs an installer only after it has downloaded completely: piping curl into a shell would
# execute a truncated script if the transfer broke off part-way. Each call gets its own file
# and returns on failure explicitly, because callers inside `if` run with errexit disabled.
run_installer() {
    local url=$1 shell=$2 installer
    installer="$(mktemp "$download_dir/installer.XXXXXX")" || return
    curl "${curl_opts[@]}" -o "$installer" "$url" || return
    "$shell" "$installer"
}
