class Package < ApplicationRecord
  has_many :package_versions, dependent: :destroy

  validates :name, presence: true, uniqueness: { allow_blank: true }

  def self.package_version?(name, version)
    joins(:package_versions)
      .exists?(name: name, package_versions: { number: version })
  end

  def latest_version_number
    package_versions.last&.number
  end
end
