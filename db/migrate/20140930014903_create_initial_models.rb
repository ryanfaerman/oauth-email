class CreateInitialModels < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :name, null: false, default: ''
      t.string :redirect_uri, null: false
      t.string :client_id, index: true
      t.string :client_secret

      t.timestamps
    end

    create_table :users do |t|
      t.string    :email, null: false, default: '', index: true
      t.string    :token
      t.datetime  :token_used_at
      t.integer   :sign_in_count, default: 0, null: false

      t.timestamps
    end

    create_table :grants do |t|
      t.integer    :type, null: false, default: 0, index: true
      t.references :user
      t.references :application
      t.string     :token
      t.datetime   :expires_at

      t.timestamps
    end
    add_index :grants, [:user_id, :application_id]

  end
end
