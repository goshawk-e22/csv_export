require 'active_support'

module CsvExport

  extend ActiveSupport::Autoload

  autoload :Base

end

ActiveSupport.on_load(:action_controller) do
  include CsvExport::Base
end
