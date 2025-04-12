# frozen_string_literal: true

class CreateBookingTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :booking_tickets do |t|
      t.references :booking, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
