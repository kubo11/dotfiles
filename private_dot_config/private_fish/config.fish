# Disable greeting
set fish_greeting

# Load environment variables
source $__fish_config_dir/environment.fish

if status is-interactive
    keychain --eval --quiet $SSH_KEYS_TO_AUTOLOAD | source
end
