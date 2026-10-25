local completion_dir="${${(%):-%N}:A:h}"
source "${completion_dir}/generate.zsh"

fpath=("$completion_dir" $fpath)
if type brew &>/dev/null; then
	fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

autoload -Uz compinit
compinit
