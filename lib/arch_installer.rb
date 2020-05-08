# frozen_string_literal: true

require 'arch_installer/cli'
require 'arch_installer/install'
require 'arch_installer/install_cli'
require 'arch_installer/runner'
require 'arch_installer/version'

module ArchInstaller
  class ArchInstallerError < StandardError; end

  class << self
    def install
      ArchInstaller::Install.instance
    end
  end
end
