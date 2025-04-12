# frozen_string_literal: true

class AddUniqueIndexToEventsTitleAndEventDate < ActiveRecord::Migration[7.1]
  def change
    add_index :events, %i[title event_date], unique: true
  end
end
