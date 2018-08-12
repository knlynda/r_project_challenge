require 'rails_helper'

RSpec.describe PackageVersion, type: :model do
  describe 'validations' do
    subject { build(:package_version) }

    it { is_expected.to be_valid }

    describe 'number' do
      context 'when blank' do
        subject { build(:package_version, number: nil) }

        it do
          is_expected.to be_invalid
          expect(subject.errors[:number]).to eq(["can't be blank"])
        end
      end

      context 'when not unique' do
        subject { build(:package_version, number: package_version.number, package: package) }
        let(:package_version) { create(:package_version) }

        context 'with the same package' do
          let(:package) { package_version.package }

          it do
            is_expected.to be_invalid
            expect(subject.errors[:number]).to eq(['has already been taken'])
          end
        end

        context 'with different packages' do
          let(:package) { create(:package) }

          it { is_expected.to be_valid }
        end
      end
    end

    describe 'title' do
      context 'when blank' do
        subject { build(:package_version, title: nil) }

        it do
          is_expected.to be_invalid
          expect(subject.errors[:title]).to eq(["can't be blank"])
        end
      end
    end

    describe 'description' do
      context 'when blank' do
        subject { build(:package_version, description: nil) }

        it do
          is_expected.to be_invalid
          expect(subject.errors[:description]).to eq(["can't be blank"])
        end
      end
    end

    describe 'published_at' do
      context 'when blank' do
        subject { build(:package_version, published_at: nil) }

        it do
          is_expected.to be_invalid
          expect(subject.errors[:published_at]).to eq(["can't be blank"])
        end
      end
    end
  end
end
