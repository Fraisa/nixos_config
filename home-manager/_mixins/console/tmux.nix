{ pkgs, darkmode, ... }:
let
  light_theme = ''
    ## COLORSCHEME: gruvbox light (medium)
    #
    # Some colors are not used by gruvbox light medium theme.
    # The main idea is to find best version of colors that fit
    # the spirit of gruvbox light theme with limited numbers of
    # 256 color palette.

    set-option -g status "on"

    # default statusbar colors
    set-option -g status-style bg=colour252,fg=colour239 # bg=notInGruvboxPallete, #fg=fg1

    # default window title colors
    set-window-option -g window-status-style bg=colour66,fg=colour229 # bg=aqua, fg=bg5

    # default window with an activity alert
    set-window-option -g window-status-activity-style bg=colour237,fg=colour241 # bg=bg1, fg=notInGruvboxPallete

    # active window title colors
    set-window-option -g window-status-current-style bg=default,fg=colour237 # bg=default, fg=bg1

    # pane border
    set-option -g pane-active-border-style fg=colour241 # fg=notInGruvboxPallete
    set-option -g pane-border-style fg=colour252 # bg1=notInGruvboxPallete

    # message infos (visible while writing command)
    set-option -g message-style bg=colour252,fg=colour241 # bg=notInGruvboxPallete, fg=notInGruvboxPallete

    # writing commands inactive
    set-option -g message-command-style bg=colour124,fg=colour241 # bg=notInGruvboxPallete, fg=notInGruvboxPallete

    # pane number display
    set-option -g display-panes-active-colour colour241 # notInGruvboxPallete
    set-option -g display-panes-colour colour248 # notInGruvboxPallete

    # clock
    set-window-option -g clock-mode-colour colour172 # orange

    # bell
    set-window-option -g window-status-bell-style bg=colour124,fg=colour229 # bg=red, fg=bg

    ## Theme settings mixed with colors (unfortunately, but there is no cleaner way)
    set-option -g status-justify "left"
    set-option -g status-left-style none
    set-option -g status-left-length "80"
    set-option -g status-right-style none
    set-option -g status-right-length "80"
    set-window-option -g window-status-separator ""

    set-option -g status-left "#[bg=colour243,fg=colour255] #S #[bg=colour252,fg=colour243,nobold,noitalics,nounderscore]"
    set-option -g status-right "#[bg=colour252,fg=colour243,nobold,nounderscore,noitalics]#[bg=colour243,fg=colour255] %Y-%m-%d  %H:%M #[bg=colour243,fg=colour237,nobold,noitalics,nounderscore]#[bg=colour237,fg=colour255] #h "

    set-window-option -g window-status-current-format "#[bg=colour215,fg=colour252,nobold,noitalics,nounderscore]#[bg=colour215,fg=colour239] #I #[bg=colour215,fg=colour239,bold] #W#{?window_zoomed_flag,*Z,} #[bg=colour252,fg=colour215,nobold,noitalics,nounderscore]"
    set-window-option -g window-status-format "#[bg=colour249,fg=colour252,noitalics]#[bg=colour249,fg=colour241] #I #[bg=colour249,fg=colour241] #W #[bg=colour252,fg=colour249,noitalics]"

    set-option -g mode-style "fg=gray, bg=blue"
  '';

  dark_theme = ''
        ## COLORSCHEME: gruvbox dark (medium)
    set-option -g status "on"

    # default statusbar color
    set-option -g status-style bg=colour237,fg=colour15 # bg=bg1, fg=fg1

    # default window title colors
    set-window-option -g window-status-style bg=colour4,fg=colour237 # bg=yellow, fg=bg1

    # default window with an activity alert
    set-window-option -g window-status-activity-style bg=colour237,fg=colour248 # bg=bg1, fg=fg3

    # active window title colors
    set-window-option -g window-status-current-style bg=red,fg=colour237 # fg=bg1

    # pane border
    set-option -g pane-active-border-style fg=colour250 #fg2
    set-option -g pane-border-style fg=colour237 #bg1

    # message infos
    set-option -g message-style bg=colour239,fg=colour15 # bg=bg2, fg=fg1

    # writing commands inactive
    set-option -g message-command-style bg=colour239,fg=colour15 # bg=fg3, fg=bg1

    # pane number display
    set-option -g display-panes-active-colour colour250 #fg2
    set-option -g display-panes-colour colour237 #bg1

    # clock
    set-window-option -g clock-mode-colour colour109 #blue

    # bell
    set-window-option -g window-status-bell-style bg=colour167,fg=colour235 # bg=red, fg=bg

    ## Theme settings mixed with colors (unfortunately, but there is no cleaner way)
    set-option -g status-justify "left"
    set-option -g status-left-style none
    set-option -g status-left-length "80"
    set-option -g status-right-style none
    set-option -g status-right-length "80"
    set-window-option -g window-status-separator ""

    set-option -g status-left "#[bg=colour241,fg=colour248] #S #[bg=colour237,fg=colour241,nobold,noitalics,nounderscore]"
    set-option -g status-right "#[bg=colour237,fg=colour239 nobold, nounderscore, noitalics]#[bg=colour239,fg=colour246] %Y-%m-%d  %H:%M #[bg=colour239,fg=colour248,nobold,noitalics,nounderscore]#[bg=colour248,fg=colour237] #h "

    set-window-option -g window-status-current-format "#[bg=colour4,fg=colour237,nobold,noitalics,nounderscore]#[bg=colour4,fg=colour239] #I #[bg=colour4,fg=colour239,bold] #W#{?window_zoomed_flag,*Z,} #[bg=colour237,fg=colour4,nobold,noitalics,nounderscore]"
    set-window-option -g window-status-format "#[bg=colour239,fg=colour237,noitalics]#[bg=colour239,fg=colour15] #I #[bg=colour239,fg=colour15] #W #[bg=colour237,fg=colour239,noitalics]"

  '';

  theme = if darkmode then dark_theme else light_theme;

  resurrectDirPath = "~/.config/tmux/resurrect";
  generatedConfigFilePath = "~/.config/tmux/tmux.conf"; # Generated by extraConfig
  tmux-nerd-font-window-name = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-nerd-font-window-name.tmux";
    version = "unstable-2023-08-22";
    rtpFilePath = "tmux-nerd-font-window-name.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "tmux-nerd-font-window-name";
      rev = "c2e62d394a290a32e1394a694581791b0e344f9a";
      sha256 = "stkhp95iLNxPy74Lo2SNes5j1AA4q/rgl+eLiZS81uA=";
    };
  };
in
{
  programs.tmux = {
    enable = true;

    # Important notice about tmux plugins and the tmux.conf that generated from
    # this tmux.nix
    #
    # in general plugins may and will conflict with each other, so the order in
    # which tmux loads them matters.  This is true when editing directly tmux.conf
    # and same applies when putting them in the plugins list in NixOS.
    #
    # Specifically in my current list. The theme plugin(nord) must be included before
    # continuum and same is true for everything that might set tmux status-right
    # as the auto save command(set -g @continuum-save-interval '1')
    # gets written into status-right. So everything that sets status-right would have to be loaded
    # beforehand.
    # Furthermore the continuum plugin must be loaded after the resurrect plugin.
    plugins = with pkgs.tmuxPlugins; [
      # The nord plugin or any other theme should on the top of the list
      # of the plugins. As it writes into the status-right which breaks the
      # set -g @continuum-save-interval for the continuum plugin.
      nord

      # This plugin needs to be loaded before continuum or else continuum, will
      # not work.
      {
          plugin = resurrect;
          extraConfig = ''

            # I have tested this strategy to work with neovim but it is not enough to have
            # Session.vim at the root of the path from which the plugin is going to do the restore
            # it is important that for neovim to be saved to be restored from the path where Session.vim
            # exist for this flow to kick in. Which means that even if tmux-resurrect saved the path with
            # Session.vim in it but vim was not open at the time of the save of the sessions then when
            # tmux-resurrect restore the window with the path with Session.vim nothing will happen.

            # Furthermore I currently using vim-startify which among other things is able to restore
            # from Session.vim if neovim is opened from the path where Session.vim exist. So in a
            # sense I don't really need tmux resurrect to restore the session as this already
            # taken care of and this functionality becomes redundant. But as I am not sure if I keep
            # using vim-startify or its auto restore feature and it do not conflict in any way that
            # I know of with set -g @resurrect-strategy-* I decided to keep it enabled for the time being.
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-strategy-vim 'session'

            set -g @resurrect-capture-pane-contents 'on'

            # This three lines are specific to NixOS and they are intended
            # to edit the tmux_resurrect_* files that are created when tmux
            # session is saved using the tmux-resurrect plugin. Without going
            # into too much details the strings that are saved for some applications
            # such as nvim, vim, man... when using NixOS, appimage, asdf-vm into the
            # tmux_resurrect_* files can't be parsed and restored. This addition
            # makes sure to fix the tmux_resurrect_* files so they can be parsed by
            # the tmux-resurrect plugin and successfully restored.
            set -g @resurrect-dir ${resurrectDirPath}
            set -g @resurrect-hook-post-save-all 'target=$(readlink -f ${resurrectDirPath}/last); sed "s| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g" $target | sponge $target'
          '';
      }

      # The copy buffer for tmux is separate from the system one, in the past in
      # order to sync the two there was a need to install tmux-yank but it looks like
      # Tmux now sends the OSC52 escape code that tells the terminal(one that support this)
      # to not display the following characters, but to copy them into the clipboard
      # instead.
      #
      # The reason that this plugin is still included because it provides a quick way to copy what
      # what is on the command line and once in copy mode to copy the PWD. I might just replace the
      # plugin with keybindings(based on send-keys).
      {
          plugin = yank;
      }
      # For some reason this plugin by default only copy into the Tmux copy buffer
      # and so I had to explicitly state the command to make it copy into the system
      # clipboard as swell.
      {
          plugin = tmux-thumbs;
          extraConfig = ''
            set -g @thumbs-command 'tmux set-buffer -- {} && tmux display-message "Copied {}" && printf %s {} | xclip -i -selection clipboard'
            set -g @thumbs-key C-y
          '';
      }
      {
          plugin = extrakto;
          extraConfig = ''
            set -g @extrakto_key M-y
            set -g @extrakto_split_direction v
          '';
      }
      # a few words about @continuum-boot and @continuum-systemd-start-cmd that
      # are not used as part of the extraConfig for the continuum plugin.
      #
      # @continuum-boot - when set will generate a user level systemd unit file
      # which it will save to ${HOME}/.config/systemd/user/tmux.service and enable
      # it.
      #
      # @continuum-systemd-start-cmd - The command used to start the tmux server
      # is determined via this configuration, and this command is set in the
      # context of the systemd unit file that is generated by setting @continuum-boot
      # when this option is not set the default will be "tmux new-session -d"
      # This setting provides a more fine grain option over the creation of the
      # systemd unit.
      #
      # Having said all that, it is important to understand that systemd units
      # are defined as .nix settings and then created when NixOS is built and
      # nothing is generated "willy-nilly" by applications.
      # So this aspect of the plugin is already taken care of by me in a separate
      # systemd unit that is responsible to start tmux when system starts.
      #
      # set -g @continuum-save-interval is written into the status-right which
      # means that any other plugin that writes into status-right needs to be
      # loaded first or the autosave functionality will not work.
      #
      # More then that it looks like the autosave feature(set -g @continuum-save-interval)
      # only works if you are attached to tmux, for some reason it does not work
      # in detached mode. Maybe if no one is attached then there is nothing
      # changing and so nothing to save.
      #
      # If autosave option interval is not set there is a default of 15 minutes
      # and it worked for me when tested.
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10'
        '';
      }
      {
          plugin = tmux-nerd-font-window-name;
          extraConfig = ''
              set -g @plugin 'joshmedeski/tmux-nerd-font-window-name'
          '';
      }


    ];

    # Replaces ~/.tmux.conf
    extraConfig = ''
      bind-key r source-file ~/.config/tmux/tmux.conf

      # List of plugins
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      set -g @plugin 'tmux-plugins/tmux-continuum'
      set -g @plugin 'tmux-plugins/tmux-yank'

      # set -g @plugin 'erikw/tmux-powerline'

      set -g mouse on
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"

      # Other examples:
      # set -g @plugin 'github_username/plugin_name'
      # set -g @plugin 'github_username/plugin_name#branch'
      # set -g @plugin 'git@github.com:user/plugin'
      # set -g @plugin 'git@bitbucket.com:user/plugin'

      set -g @continuum-restore 'on'

      ## Hotkey changes
      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # source "/usr/share/tmux/powerline.conf"


      ${theme}


      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      run '~/.tmux/plugins/tpm/tpm'

    '';
  };
}
