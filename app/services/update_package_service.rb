class UpdatePackageService
  def initialize(attributes)
    @package_name = attributes[:name]
    @package_version_attrs = attributes.slice(:number, :title, :description, :published_at)
    @authors_attributes = attributes.delete(:authors)
    @maintainers_attributes = attributes.delete(:maintainers)
  end

  def call
    package = Package.find_or_create_by!(name: package_name)
    package_version = PackageVersion.create!(package: package, **package_version_attrs)
    create_authors(package_version)
    create_maintainers(package_version)
  end

  private

  attr_reader :package_name, :package_version_attrs, :authors_attributes, :maintainers_attributes

  def create_authors(package_version)
    authors_attributes.each do |author_attributes|
      PackageVersionsAuthor.create!(
        contributor: find_or_create_contributor(author_attributes),
        package_version: package_version
      )
    end
  end

  def create_maintainers(package_version)
    maintainers_attributes.each do |maintainers_attribute|
      PackageVersionsMaintainer.create!(
        contributor: find_or_create_contributor(maintainers_attribute),
        package_version: package_version
      )
    end
  end

  def find_or_create_contributor(attributes)
    return Contributor.create!(attributes) if attributes[:email].blank?
    Contributor.find_by(email: attributes[:email]) || Contributor.create!(attributes)
  end
end
