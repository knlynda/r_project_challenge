FactoryBot.define do
  factory :package do
    sequence(:name) { |n| "test_package_#{n}" }
  end
end
