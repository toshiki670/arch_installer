# frozen_string_literal: true

require 'arch_installer/install/pacstrap'
require 'singleton'

module ArchInstaller
  class Install
    include Singleton

    def encryption

    end

    def install_system
      p 'mock'
    end

    def format
      p 'mock'
    end

    def mount

    end

    def pertition

    end
  end
end
