FactoryBot.define do
  factory :package_version do
    sequence(:number) { |n| "0.0.#{n}" }
    title 'Test package title'
    description 'Test package description'
    published_at { Time.current }

    after(:build) do |package_version|
      package_version.package = create(:package) if package_version.package_id.blank?
    end
  end
end
