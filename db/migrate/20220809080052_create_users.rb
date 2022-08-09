class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password

      t.timestamps
    end

    create_table :chats do |t|
      t.string :senderId
      t.string :recieverId
      t.string :message

      t.timestamps
    end
  end
end
