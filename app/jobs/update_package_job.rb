class UpdatePackageJob < ApplicationJob
  queue_as :default

  def perform(name, version)
    return if Package.package_version?(name, version)
    attributes = ParsePackageService.new(name, version).call
    UpdatePackageService.new(attributes).call
  end
end
