class CreateSubscriptionsLists < ActiveRecord::Migration
  def self.up
    create_table :subscriptions_lists do |t|

      t.column :project_id, :integer
      t.column :name, :string

    end
  end

  def self.down
    drop_table :subscriptions_lists
  end
end
