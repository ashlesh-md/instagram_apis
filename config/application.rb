require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Instagram
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true
    config.autoload_paths += %W(#{config.root}/app/services)
  end
end
