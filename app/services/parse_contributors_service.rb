class ParseContributorsService
  class << self
    def call(contributor_string)
      contributor_string
        .gsub(SANITIZE_PATTERN, '')
        .split(SPLIT_PATTERN)
        .map do |contributor|

        {
          name: parse_name(contributor),
          email: parse_email(contributor)
        }
      end
    end

    private

    NAME_PATTERN = /\A([^<]+)<?.*\z/
    private_constant :NAME_PATTERN

    EMAIL_PATTERN = /\A.+<([^>]+)>\z/
    private_constant :EMAIL_PATTERN

    SANITIZE_PATTERN = / *(?:\([^\)]+\)|\[[^\]]+\]|<[^@>]+>|\n) */
    private_constant :SANITIZE_PATTERN

    SPLIT_PATTERN = /(?: +and +| *, *)/
    private_constant :SPLIT_PATTERN

    def parse_name(string)
      return unless string =~ NAME_PATTERN
      string.gsub(NAME_PATTERN, '\1').strip
    end

    def parse_email(string)
      return unless string =~ EMAIL_PATTERN
      string.gsub(EMAIL_PATTERN, '\1').strip
    end
  end
end
