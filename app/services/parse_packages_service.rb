class ParsePackagesService
  class << self
    def call
      OpenURI
        .open_uri(REPO_URL)
        .lazy
        .each(INFO_SEPARATOR)
        .map(&method(:parse_package_info))
        .first(BATCH_SIZE)
    end

    private

    REPO_URL = 'https://cran.r-project.org/src/contrib/PACKAGES'.freeze
    private_constant :REPO_URL

    INFO_SEPARATOR = "\n\n".freeze
    private_constant :INFO_SEPARATOR

    BATCH_SIZE = ENV.fetch('PACKAGES_BATCH_SIZE', 50)
    private_constant :BATCH_SIZE

    INFO_ATTRS = %w[Package Version].freeze
    private_constant :INFO_ATTRS

    def parse_package_info(info)
      Dcf.parse(info).first.slice(*INFO_ATTRS)
    end
  end
end
