# adds functions to call right before every command is executed
# ensure preexec_functions is an array, then append to it
if [[ -z ${preexec_functions} ]]; then
    declare -a preexec_functions
fi
preexec_functions+=(
    "set-tab-title-by-process-name"
)

set-tab-title-by-process-name() {
    set-tab-title ${1}
}