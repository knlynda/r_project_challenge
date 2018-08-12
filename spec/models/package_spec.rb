require 'rails_helper'

RSpec.describe Package, type: :model do
  describe 'validations' do
    subject { build(:package) }

    it { is_expected.to be_valid }

    describe 'name' do
      context 'when blank' do
        subject { build(:package, name: nil) }

        it do
          is_expected.to be_invalid
          expect(subject.errors[:name]).to eq(["can't be blank"])
        end
      end

      context 'when not unique' do
        subject { build(:package, name: create(:package).name) }

        it do
          is_expected.to be_invalid
          expect(subject.errors[:name]).to eq(['has already been taken'])
        end
      end
    end
  end

  describe '.package_version?' do
    subject { described_class.package_version?(name, version) }
    let(:name) { 'test_package' }
    let(:version) { '1.1.1' }

    context 'when package exists' do
      let!(:package) { create(:package, name: name) }

      context 'when package version does not exist' do
        it { is_expected.to be_falsey }
      end

      context 'when package version exists' do
        before { create(:package_version, number: version, package: package) }

        it { is_expected.to be_truthy }
      end
    end

    context 'when package does not exist' do
      context 'when package version does not exist' do
        it { is_expected.to be_falsey }
      end

      context 'when package version exists' do
        let!(:package_version) { create(:package_version, number: version) }

        it { is_expected.to be_falsey }
      end
    end
  end
end
