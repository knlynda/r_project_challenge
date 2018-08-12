require 'rails_helper'

RSpec.describe UpdatePackageService, type: :model do
  describe '#call' do
    subject { service.call }
    let(:service) { described_class.new(attributes) }
    let(:package) { instance_double('Package') }
    let(:package_version) { instance_double('PackageVersion') }
    let(:author) { instance_double('Contributor') }
    let(:maintainer) { instance_double('Contributor') }

    let(:attributes) do
      {
        number: '0.0.1',
        name: 'test_package',
        title: 'Test Package',
        description: 'Test description',
        published_at: '2018-08-09 22:00:00 UTC',
        authors: [{ email: 'author@test.xx', name: 'Test author' }],
        maintainers: [{ email: 'maintainer@test.xx', name: 'Test maintainer' }]
      }
    end

    it do
      expect(Package).to receive(:find_or_create_by!).with(name: 'test_package').once { package }
      expect(PackageVersion).to receive(:create!).with(
        package: package,
        number: '0.0.1',
        title: 'Test Package',
        description: 'Test description',
        published_at: '2018-08-09 22:00:00 UTC'
      ).once { package_version }

      expect(Contributor).to receive(:create!).with(
        email: 'author@test.xx', name: 'Test author'
      ).once { author }

      expect(Contributor).to receive(:create!).with(
        email: 'maintainer@test.xx', name: 'Test maintainer'
      ).once { maintainer }

      expect(PackageVersionsAuthor).to receive(:create!).with(
        contributor: author, package_version: package_version
      ).once

      expect(PackageVersionsMaintainer).to receive(:create!).with(
        contributor: maintainer, package_version: package_version
      ).once

      subject
    end
  end
end
