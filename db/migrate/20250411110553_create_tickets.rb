# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.references :event, null: false, foreign_key: true
      t.string :ticket_type
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
