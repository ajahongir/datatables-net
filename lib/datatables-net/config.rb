require 'active_support/configurable'

module DatatablesNet

  # configure DatatablesNet global settings
  #   DatatablesNet.configure do |config|
  #     config.db_adapter = :pg
  #   end
  def self.configure
    yield @config ||= DatatablesNet::Configuration.new
  end

  # DatatablesNet global settings
  def self.config
    @config ||= DatatablesNet::Configuration.new
  end

  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:orm) { :active_record }
    config_accessor(:db_adapter) { :pg }
  end
end
