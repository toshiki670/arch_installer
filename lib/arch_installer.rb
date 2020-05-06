require 'arch_installer/install'
require 'arch_installer/runner'
require 'arch_installer/version'

module ArchInstaller
  class Error < StandardError; end
  # Your code goes here...

  class << self
    def test
      puts "main test method"
    end
  end
end
