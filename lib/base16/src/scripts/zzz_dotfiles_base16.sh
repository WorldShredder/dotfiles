# start-base16-shell
BASE16_SHELL="$HOME/.config/base16-shell/"
if [ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ]; then
    source "$BASE16_SHELL/profile_helper.sh"
    base16_{{BASE16_DEFAULT_THEME}}
fi
# end-base16-shell
