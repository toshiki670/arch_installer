# frozen_string_literal: true

require 'delegate'
require 'singleton'
require 'logger'

module ArchInstaller
  class Logger < Delegator
    include Singleton

    DEFAULT_LEVEL = ::Logger::Severity::INFO

    attr_reader :logger

    def initialize
      init(STDOUT, level: ::Logger::Severity::DEBUG)
    end

    def init(logdev = default_output, level: ::ArchInstaller::Logger::DEFAULT_LEVEL)
      @logger = ::Logger.new(logdev, level: level)
      nil
    end

    private

    def default_output
      "./#{Time.new.strftime('%F_%T')}.log"
    end

    def __getobj__
      @logger
    end

    def __setobj__(logger)
      @logger = logger
    end
  end
end
