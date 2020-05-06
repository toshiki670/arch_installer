require 'arch_installer/install'
require 'arch_installer/runner'
require 'arch_installer/version'

module ArchInstaller
  class Error < StandardError; end

  class << self
    def install
      ArchInstaller::Install.instance
    end
  end
end
