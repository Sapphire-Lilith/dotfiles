_completion_dir="${${(%):-%N}:A:h}"

([[ -o login ]] && [[ -o interactive ]]) || return

function generate_completion_if_updated() {
	local name=$1
	local gen_cmd=$2
	local ver_cmd=${3:-"$name --version"}

	if ! command -v "$name" >/dev/null 2>&1; then
		return
	fi

	local dest="$_completion_dir/_$name"
	local version="$dest.version"

	local cur_ver="$(eval "$ver_cmd" 2>/dev/null || echo unknown)"
	if [[ ! -r "$dest" || ! -r "$version" || "$(<"$version")" != "$cur_ver" ]]; then
		eval "$gen_cmd" >! "$dest"
		echo "$cur_ver" >! "$version"
	fi
}

generate_completion_if_updated chezmoi "chezmoi completion zsh"
generate_completion_if_updated sheldon "sheldon completions --shell zsh"
generate_completion_if_updated mise "mise completion zsh"

generate_completion_if_updated gh "gh completion --shell zsh"
generate_completion_if_updated docker "docker completion zsh"
generate_completion_if_updated kubectl "kubectl completion zsh" "kubectl version --client"

generate_completion_if_updated rustup "rustup completions zsh"
generate_completion_if_updated cargo "rustup completions zsh cargo"
generate_completion_if_updated uv "uv generate-shell-completion zsh"
generate_completion_if_updated uvx "uvx --generate-shell-completion zsh"
generate_completion_if_updated pixi "pixi completion --shell zsh"
generate_completion_if_updated pnpm "pnpm completion zsh"
generate_completion_if_updated op "op completion zsh"

generate_completion_if_updated starship "starship completions zsh"
generate_completion_if_updated hx 'cat "$(mise where helix)"/*/contrib/completion/hx.zsh'
generate_completion_if_updated fastfetch 'cat "$(mise where fastfetch)"/*/usr/share/zsh/site-functions/_fastfetch'

generate_completion_if_updated codex "codex completion zsh"
