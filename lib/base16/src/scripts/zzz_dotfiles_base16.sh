# start-base16-shell
BASE16_SHELL="$HOME/.config/base16-shell/"
if [ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ]; then
    source "$BASE16_SHELL/profile_helper.sh"
fi
base16_{{BASE16_DEFAULT_THEME}}
# end-base16-shell
