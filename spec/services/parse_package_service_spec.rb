require 'rails_helper'

RSpec.describe ParsePackageService, type: :model do
  describe '#call' do
    subject { service.call }
    let(:service) { described_class.new(name, version) }
    let(:name) { 'test_package' }
    let(:version) { '0.0.1' }
    let(:package_url) { format('https://cran.r-project.org/src/contrib/%s_%s.tar.gz', name, version) }

    before do
      allow(OpenURI).to receive(:open_uri).with(package_url) do
        File.open(Rails.root.join('spec', 'fixtures', 'test_package_0.0.1.tar.gz'))
      end
    end

    it do
      is_expected.to eq(
        number: '0.0.1',
        name: 'test_package',
        title: 'Test Package',
        description: 'Test description',
        published_at: '2018-08-09 22:00:00 UTC',
        authors: [{ email: 'author@test.xx', name: 'Test author' }],
        maintainers: [{ email: 'maintainer@test.xx', name: 'Test maintainer' }]
      )
    end
  end
end
