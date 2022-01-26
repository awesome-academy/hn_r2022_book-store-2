class CreatePublishers < ActiveRecord::Migration[6.1]
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :phone
      t.text :website
      t.text :desc

      t.timestamps
    end
  end
end
