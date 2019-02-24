# set the title of the terminal
function set-tab-title() {
    echo -ne "\e]1;$@\a"
}