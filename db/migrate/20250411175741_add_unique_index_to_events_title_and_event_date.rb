class AddUniqueIndexToEventsTitleAndEventDate < ActiveRecord::Migration[7.1]
  def change
    add_index :events, [:title, :event_date], unique: true
  end
end
