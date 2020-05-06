module ArchInstaller
  class Install
    class System

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
      ]

      KDE_PKG = [
        'plasma',
        'konsole',
        'dolphin',
        'filelight',
        'ark',
        'gwenview',
        'cryfs',
        'gitg'
      ]

      # Favorite_pkg
      DOTFILES_PKG = [
        'zsh',
        'git',
        'vim',
        'neovim',
        'words'
      ]

      def pacstrap
        p "ok"
      end
    end
  end
end
