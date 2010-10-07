class CreateReminders < ActiveRecord::Migration
  def self.up
    create_table :reminders do |t|
      t.integer :user_id
      t.string :status_id
      t.string :message_id
      t.string :text
      t.boolean :complete, :default => false
      t.text :tweet

      t.timestamps
    end
  end

  def self.down
    drop_table :reminders
  end
end
