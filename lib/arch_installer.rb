require 'arch_installer/version'
require 'arch_installer/runner'

module ArchInstaller
  class Error < StandardError; end
  # Your code goes here...

  class << self
    def test
      puts "main test method"
    end
  end
end
