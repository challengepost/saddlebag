require 'active_support/core_ext/class/attribute'

# Public:
# Pick an asset host for the given source and request. Returns nil if no request is
# given or not host is provided in settings, the host if no wildcard is set,
# the host interpolated with the numbers 0-3 if it contains %d (the number is
# the source hash mod 4) or the value returned from invoking call.
#
# Usage
#
#   # in application.rb
#   config.controller.asset_host = Saddlebag::AssetHost.new
#
#   Saddlebag::AssetHost.configure do |a|
#     a.enabled = true
#     a.asset_host = 'http://assets%d.example.com'
#     a.secure_asset_host = 'https://secureassets.example.com'
#   end
#
module Saddlebag
  class AssetHost
    class_attribute :enabled, :asset_host, :secure_asset_host

    attr_accessor :asset_host, :secure_asset_host

    def self.configure(options = {})
      options.each { |k,v| self.send("#{k}=", v) }
      yield self if block_given?
    end

    def call(*args)
      source, request = args

      case
      when skip?(request)
        nil
      when request.ssl?
        secure_asset_host
      else
        hashed_asset_host(source)
      end
    end

    def secure_asset_host
      self.class.secure_asset_host
    end

    def asset_host
      self.class.asset_host
    end

    def hashed_asset_host(source)
      asset_host % (source.hash % 4)
    end

    def skip?(request)
      request.nil? || !self.class.enabled
    end

  end
end
