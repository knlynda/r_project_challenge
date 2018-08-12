class CreatePackageVersionsContributors < ActiveRecord::Migration[5.2]
  def change
    create_table :package_versions_contributors do |t|
      t.string :type, null: false
      t.references :contributor, null: false
      t.references :package_version, null: false

      t.timestamps
    end
  end
end
