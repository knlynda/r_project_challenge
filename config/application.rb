require_relative 'boot'

require 'rails/all'
require 'open-uri'
require 'dcf'
require 'rubygems/package'
require 'zlib'

Bundler.require(*Rails.groups)
Dotenv::Railtie.load

module RProjectChallenge
  class Application < Rails::Application
    config.load_defaults 5.2
    config.active_job.queue_adapter = :sidekiq
  end
end
