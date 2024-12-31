# /etc/profile

# Set our umask
umask 022

# Append our default paths
appendpath () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

appendpath '/usr/local/sbin'
appendpath '/usr/local/bin'
appendpath '/usr/bin'
appendpath '/home/void/.sh'
unset appendpath

export PATH

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
	for profile in /etc/profile.d/*.sh; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi

# Source global bash config
if test "$PS1" && test "$BASH" && test -z ${POSIXLY_CORRECT+x} && test -r /etc/bash.bashrc; then
	. /etc/bash.bashrc
fi

# Termcap is outdated, old, and crusty, kill it.
unset TERMCAP

# Man is much better than us at figuring this out
unset MANPATH

unset HISTFILE

export EDITOR=nano
export LANG=en_US.UTF-8
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_PLATFORMTHEME=qt5ct
export QT_PLATFORM_PLUGIN=qt5ct
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.sh

export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland
#export XDG_CURRENT_DESKTOP=Hyprland
export QT_QPA_PLATFORM=wayland-egl
export GDK_BACKEND=wayland
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland
export MOZ_ENABLE_WAYLAND=1
export SDL_VIDEODRIVER=wayland
export ELM_DISPLAY=wl
export _JAVA_AWT_WM_NONREPARENTING=1

export XKB_DEFAULT_LAYOUT=br
export XKB_DEFAULT_MODEL=thinkpad

export DRI_PRIME=1
export NIXPKGS_ALLOW_UNFREE=1

export PS1='\[\033[01;34m\]\u@\h\[\033[00m\]:\[\033[01;38m\]\w\[\033[00m\]\$ '
