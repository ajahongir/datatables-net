require 'rails/generators'

module Datatable
  module Generators
    class ConfigGenerator < ::Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      desc <<DESC
Description:
  Creates an initializer file for DatatablesNet configuration at config/initializers.
DESC

      def copy_config_file
        template 'datatables_net_config.rb', 'config/initializers/datatables_net_config.rb'
      end
    end
  end
end
