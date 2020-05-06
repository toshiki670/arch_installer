# frozen_string_literal: true

require 'arch_installer/install'
require 'arch_installer/version'

require 'thor'

module ArchInstaller
  class Runner < Thor
    package_name 'ArchInstaller'

    desc 'install', 'Install archlinux system.'
    def install
      installer = ArchInstaller::Install.instance

      p installer
    end

    desc 'setting', "Setting after `chroot'."
    def setting
      puts 'TODO: setting'
    end
  end
end
