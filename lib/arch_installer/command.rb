# frozen_string_literal: true

require 'open3'

module ArchInstaller
  class Command
    def self.exec(*args)
      Open3.popen3(*args) do |stdin, stdout, stderr, _|
        stdin.close_write

        stdout.each_line do |line|
          ArchInstaller.logger.info do
            line
          end
        end

        stderr.each_line do |line|
          ArchInstaller.logger.error do
            line
          end
        end
      end
    end
  end
end
