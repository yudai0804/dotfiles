function git-prompt {
	local branchname branch st remote pushed upstream
	branchname=`git symbolic-ref --short HEAD 2> /dev/null`
	if [ -z $branchname ]; then
		return
	fi
	st=`git status 2> /dev/null`
	if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
		branch="%{${fg[cyan]}%}($branchname)%{$reset_color%}"
	elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
		branch="%{${fg[yellow]}%}($branchname)%{$reset_color%}"
	else
		branch="%{${fg[green]}%}($branchname)%{$reset_color%}"
	fi

	remote=`git config branch.${branchname}.remote 2> /dev/null`

	if [ -z $remote ]; then
		pushed=''
	else
		upstream="${remote}/${branchname}"
		if [[ -z `git log ${upstream}..${branchname}` ]]; then
			pushed="%{${fg[cyan]}%}[up]%{$reset_color%}"
		else
			pushed="%{${fg[green]}%}[up]%{$reset_color%}"
		fi
	fi

	echo "$branch$pushed"
}
function update_prompt() {
	PROMPT="${fg[green]}%n@%m${reset_color} ${fg[yellow]}%~${reset_color} `git-prompt`
%# "
}
add-zsh-hook precmd update_prompt
