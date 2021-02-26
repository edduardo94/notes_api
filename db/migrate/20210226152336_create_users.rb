class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest

      t.timestamps

      t.index ['email'], name: 'index_users_on_email', unique: true
    end
  end
end
