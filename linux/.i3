# Mod4 is usually mapped to the Super (Windows) key.
# Run xmodmap to check mod mappings.
set $mod Mod4

# Focus window
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# Move window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# Resize window
# top edge up
bindsym $mod+Mod1+k resize grow up 100 px
# top edge down
bindsym $mod+Mod1+j resize shrink up 100 px
# right edge right
bindsym $mod+Mod1+l resize grow right 100 px
# right edge left
bindsym $mod+Mod1+h resize shrink right 100 px
# bottom edge up
bindsym $mod+Mod1+Shift+k resize shrink down 100 px
# bottom edge down
bindsym $mod+Mod1+Shift+j resize grow down 100 px
# left edge right
bindsym $mod+Mod1+Shift+l resize shrink left 100 px
# left edge left
bindsym $mod+Mod1+Shift+h resize grow left 100 px

# Workspaces
# Note we use "workspace number 1" instead of "workspace 1" so that we can
# rename workspaces to e.g. "1-foo" but still use the number keys to reference
# them.
bindsym $mod+1 workspace number 1
bindsym $mod+2 workspace number 2
bindsym $mod+3 workspace number 3
bindsym $mod+4 workspace number 4
bindsym $mod+5 workspace number 5
bindsym $mod+6 workspace number 6
bindsym $mod+7 workspace number 7
bindsym $mod+8 workspace number 8
bindsym $mod+9 workspace number 9
bindsym $mod+0 workspace number 10
bindsym $mod+Shift+1 move container to workspace number 1
bindsym $mod+Shift+2 move container to workspace number 2
bindsym $mod+Shift+3 move container to workspace number 3
bindsym $mod+Shift+4 move container to workspace number 4
bindsym $mod+Shift+5 move container to workspace number 5
bindsym $mod+Shift+6 move container to workspace number 6
bindsym $mod+Shift+7 move container to workspace number 7
bindsym $mod+Shift+8 move container to workspace number 8
bindsym $mod+Shift+9 move container to workspace number 9
bindsym $mod+Shift+0 move container to workspace number 10
bindsym $mod+r exec i3-input -F 'rename workspace to "%s"' -P 'New name for this workspace: '

# Layout
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# Fullscreen
bindsym $mod+f fullscreen

# Floating
bindsym $mod+Shift+space floating toggle
bindsym $mod+space focus mode_toggle
bindsym $mod+p sticky toggle
floating_modifier $mod

# Container splitting
bindsym $mod+v split v
bindsym $mod+b split h

# Container focus
bindsym $mod+a focus parent
# focus the child container
bindsym $mod+Shift+a focus child

# Kill window
bindsym $mod+Shift+q kill

# Launching apps
bindsym $mod+d exec dmenu_run
bindsym $mod+Return exec i3-sensible-terminal
bindsym $mod+c exec google-chrome

# Scratchpad
bindsym $mod+Shift+backslash move scratchpad
bindsym $mod+backslash scratchpad show

# Special scratch windows
bindsym $mod+m exec i3-chrome-scratch.sh https://open.spotify.com/ open.spotify.com
bindsym $mod+question exec i3-chrome-scratch.sh https://www.aomarks.com/cheat.html www.aomarks.com__cheat.html
bindsym $mod+y exec i3-chrome-scratch.sh https://youtube.com/ youtube.com
bindsym $mod+grave exec i3-scratch-term.sh

# Screenshot
bindsym $mod+Shift+s exec maim -s | xclip -selection clipboard -t image/png

# Reload/Restart/Exit i3
bindsym $mod+Shift+c reload
bindsym $mod+Shift+r restart
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# Volume
bindsym XF86AudioRaiseVolume exec amixer set Master 1%+
bindsym XF86AudioLowerVolume exec amixer set Master 1%-
bindsym XF86AudioMute        exec amixer set Master toggle

# Font for window titles and bar
font pango:Ubuntu Mono 10

# X specific configuration. May or may not have already happened depending on
# how i3 was launched.
exec_always --no-startup-id "sh .xprofile"

# Compton compositor
exec --no-startup-id compton --backend=glx

# i3bar
bar {
  status_command i3status
  tray_output primary
  position top
}

# No window titles
for_window[class=".*"] border pixel 1
