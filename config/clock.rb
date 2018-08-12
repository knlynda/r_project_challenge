require 'rubygems'
require 'clockwork'
require_relative './boot'
require_relative './environment'

module Clockwork
  every(
    12.hours,
    'Update packages',
    at: %w[00:00 12:00]
  ) { UpdatePackagesObserverJob.perform_later }
end
