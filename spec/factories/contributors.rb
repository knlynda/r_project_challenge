FactoryBot.define do
  factory :contributor do
    name 'test contributor'
    sequence(:email) { |n| "contributor_#{n}@test.xx" }
  end
end
