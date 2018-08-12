class PackageVersion < ApplicationRecord
  belongs_to :package

  has_many :package_versions_authors, dependent: :destroy
  has_many :package_versions_maintainers, dependent: :destroy

  has_many :authors, through: :package_versions_authors, source: :contributor
  has_many :maintainers, through: :package_versions_maintainers, source: :contributor

  validates :number, presence: true, uniqueness: { scope: :package_id, allow_blank: true }
  validates :title, presence: true
  validates :description, presence: true
  validates :published_at, presence: true
end
