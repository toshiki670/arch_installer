# frozen_string_literal: true

require 'arch_installer/install/system'
require 'singleton'

module ArchInstaller
  class Install
    include Singleton

    def pertition
      p 'mock'
    end

    def lvm
      p 'mock'
    end
  end
end
