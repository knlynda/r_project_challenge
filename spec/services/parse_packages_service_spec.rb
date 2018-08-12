require 'rails_helper'

RSpec.describe ParsePackagesService, type: :model do
  describe '.call' do
    subject { service.call }
    let(:service) { described_class }
    let(:packages_url) { 'https://cran.r-project.org/src/contrib/PACKAGES' }

    before do
      allow(OpenURI).to receive(:open_uri).with(packages_url) do
        File.open(Rails.root.join('spec', 'fixtures', 'packages.txt'))
      end
    end

    it do
      is_expected.to eq(
        [
          { 'Package' => 'test_package_1', 'Version' => '0.0.1' },
          { 'Package' => 'test_package_2', 'Version' => '0.0.2' },
          { 'Package' => 'test_package_3', 'Version' => '0.0.3' },
          { 'Package' => 'test_package_4', 'Version' => '0.0.4' },
          { 'Package' => 'test_package_5', 'Version' => '0.0.5' }
        ]
      )
    end
  end
end
