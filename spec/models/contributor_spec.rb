require 'rails_helper'

RSpec.describe Package, type: :model do
  describe 'validations' do
    subject { build(:contributor) }

    it { is_expected.to be_valid }

    describe 'name' do
      context 'when blank' do
        subject { build(:contributor, name: nil) }

        it do
          is_expected.to be_invalid
          expect(subject.errors[:name]).to eq(["can't be blank"])
        end
      end
    end

    describe 'email' do
      context 'when not unique' do
        subject { build(:contributor, email: create(:contributor).email) }

        it do
          is_expected.to be_invalid
          expect(subject.errors[:email]).to eq(['has already been taken'])
        end

        context 'when blank' do
          subject { build(:contributor, email: create(:contributor, email: nil).email) }

          it { is_expected.to be_valid }
        end
      end
    end
  end
end
