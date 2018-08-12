require 'rails_helper'

RSpec.describe ParseContributorsService do
  describe '.call' do
    subject { described_class.call(contributor_string) }

    {
      'test' => [{ name: 'test', email: nil }],
      'test user' => [{ name: 'test user', email: nil }],
      'test user <test>' => [{ name: 'test user', email: nil }],
      'test user [test] <test>' => [{ name: 'test user', email: nil }],
      'test user <test@test.xx>' => [{ name: 'test user', email: 'test@test.xx' }],
      'test user <test@test.xx> and user' => [
        { name: 'test user', email: 'test@test.xx' },
        { name: 'user', email: nil }
      ],
      'test user <test@test.xx>, user <email@text.xx>' => [
        { name: 'test user', email: 'test@test.xx' },
        { name: 'user', email: 'email@text.xx' }
      ]
    }.each do |contributor_string, result|
      context "when contributor_string is '#{contributor_string}'" do
        let(:contributor_string) { contributor_string }

        it { is_expected.to eq(result) }
      end
    end
  end
end
