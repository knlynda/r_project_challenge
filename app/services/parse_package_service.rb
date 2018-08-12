class ParsePackageService
  def initialize(name, version)
    @name = name
    @version = version
  end

  def call
    {
      name: description_info['Package'],
      number: description_info['Version'],
      title: description_info['Title'],
      description: description_info['Description'],
      published_at: description_info['Date/Publication'],
      **contributors_attributes
    }
  end

  private

  URL_FORMAT = 'https://cran.r-project.org/src/contrib/%s_%s.tar.gz'.freeze
  private_constant :URL_FORMAT

  DESCRIPTION_FILE_PATTERN = %r{[^/]+/DESCRIPTION}
  private_constant :DESCRIPTION_FILE_PATTERN

  attr_reader :name, :version

  def contributors_attributes
    {
      authors: ParseContributorsService.call(description_info['Author']),
      maintainers: ParseContributorsService.call(description_info['Maintainer'])

    }
  end

  def description_info
    @description_info ||= Dcf.parse(description_source).first
  end

  def description_source
    return @description_source if @description_source

    gz = Zlib::GzipReader.new(package_source)
    tar = Gem::Package::TarReader.new(gz)
    @description_source = tar.find { |entry| entry.full_name.to_s =~ DESCRIPTION_FILE_PATTERN }.read
  end

  def package_source
    @package_source ||= OpenURI.open_uri(format(URL_FORMAT, name, version))
  end
end
