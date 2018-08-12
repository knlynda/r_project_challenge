class UpdatePackagesObserverJob < ApplicationJob
  queue_as :default

  def perform
    ParsePackagesService.call.map do |info|
      UpdatePackageJob.perform_later(info['Package'], info['Version'])
    end
  end
end
