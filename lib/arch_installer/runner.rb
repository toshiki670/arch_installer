require 'arch_installer/install'
require 'arch_installer/version'

require 'thor'

module ArchInstaller
  class Runner < Thor
    package_name 'ArchInstaller'

    desc 'install', %q{Install archlinux system}
    def install
      puts 'TODO: install'
    end

    desc 'setting', %q{Setting after `chroot'}
    def setting
      puts 'TODO: setting'
    end
  end
end
