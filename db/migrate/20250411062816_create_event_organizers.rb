# frozen_string_literal: true

class CreateEventOrganizers < ActiveRecord::Migration[7.1]
  def change
    create_table :event_organizers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name
      t.string :phone_number

      t.timestamps
    end
  end
end
