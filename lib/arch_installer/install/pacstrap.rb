# frozen_string_literal: true

module ArchInstaller
  class Install
    class Pacstrap
      CMD_NAME = 'pacstrap'

      CORE_PKG = [
        'base',
        'base-devel',
        'linux',
        'linux-firmware',
        'xfsprogs',
        'pacman-contrib',
        'pkgfile',
        'dhcpcd',
        'openssh',
        'wget'
      ].map(&:freeze).freeze

      KDE_PKG = [
        'plasma',
        'konsole',
        'dolphin',
        'filelight',
        'ark',
        'gwenview',
        'cryfs',
        'gitg'
      ].map(&:freeze).freeze

      # Favorite_pkg
      DOTFILES_PKG = [
        'zsh',
        'git',
        'vim',
        'neovim',
        'words'
      ].map(&:freeze).freeze

      def pacstrap
        p 'ok'
      end
    end
  end
end
