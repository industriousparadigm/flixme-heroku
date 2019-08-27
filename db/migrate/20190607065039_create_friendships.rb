class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :requester_id
      t.integer :receiver_id
      t.boolean :request_accepted

      t.timestamps
    end
  end
end
