class CreatePackageVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :package_versions do |t|
      t.string :number, null: false
      t.text :title, null: false
      t.text :description, null: false
      t.datetime :published_at, null: false
      t.references :package, null: false

      t.timestamps
    end
  end
end
