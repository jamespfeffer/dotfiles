# B52s
set -U fish_greeting "\
I'll give you $(set_color yellow)󰈺$(set_color normal),
I'll give you $(set_color red)󱥰$(set_color normal),
I'll give you $(set_color magenta)󱢏$(set_color normal)
https://www.youtube.com/watch?v=BaG6XgtQSc8"

# set up vi keybindings
# fish_key_bindings is a variable which points to a function called to set bindings
# fish_vi_key_bindings is a function which not only sets up the vi-style bindings
# but also itself sets fish_key_bindings to fish_vi_keybinds as a universal 
# variable (ie it's stored on disk at ~/.config/fish/variables). This means
# (I think) that the key bindings are preserved even if this config file goes 
# out of existence. As far as I can tell just calling fish_vi_key_bindings
# does the sames thing, but maybe it is done as follows because it isn't guaranteed that
# the function pointed to will set fish_key_bindings.
set -g fish_key_bindings fish_vi_key_bindings
set -g fish_vi_force_cursor 1

# Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      
set fish_cursor_insert      line       
set fish_cursor_replace_one underscore 
set fish_cursor_visual      block

# Don't underline paths
set fish_color_valid_path 
# Don't underline the already typed part of completion alternatives
set fish_pager_color_prefix 'normal'  '--bold' 


# initialise oh-my-posh
oh-my-posh init fish --config ~/.config/oh-my-posh/jzp-turquoise.yaml | source


# fish-mode-prompt is a function called whenever the prompt is drawn
# Configure it to vary the icon displayed according to the vi mode
function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color 27595d
      echo '╭─'
      set_color --background 27595d
      set_color ffffff
     echo '󰆾 '
     set_color --background 'normal'
     set_color 27595d
     echo ''
    case insert
      set_color 27595d
      echo '╭─'
      set_color --background 27595d
      set_color ffffff
      echo ' '
      set_color --background 'normal'
      set_color 27595d
      echo ''
    case replace_one
      set_color 27595d
      echo '╭─'
      set_color --background 27595d
      set_color ffffff
      echo ' '
      set_color --background 'normal'
      set_color 27595d
      echo ''
     case visual
      set_color 27595d
      echo '╭─'
      set_color --background 27595d
      set_color ffffff
    echo '󰒉 '
      set_color --background 'normal'
      set_color 27595d
      echo ''
    case '*'
      set_color 27595d
      echo '╭─'
      set_color --background 27595d
      set_color ffffff
      echo '?'
      set_color --background 'normal'
      set_color 27595d
      echo ''
  end
  set_color normal
end
