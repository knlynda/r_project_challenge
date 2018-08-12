class PackageVersionsContributor < ApplicationRecord
  belongs_to :contributor
  belongs_to :package_version
end
