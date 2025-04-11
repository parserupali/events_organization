class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :event_date
      t.string :venue
      t.references :event_organizer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
