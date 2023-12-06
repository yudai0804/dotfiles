function is_venv_active {
	if [[ `which python3` =~ 'venv' ]]; then
		echo 'venv active'
		return 1
	else
		echo 'no venv'
		return 0
	fi
}
# function hoge(){
# 	`is_venv_active`
# 	local status = $?
# 	if [ $status = 1 ]; then
# 		echo 'hoge'
# 	fi
# }

# hoge()
is_venv_active
