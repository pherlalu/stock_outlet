class AddDeviseToCustomers < ActiveRecord::Migration[7.1]
  def change
    change_table :customers do |t|
      # Add only the necessary Devise columns
      unless column_exists?(:customers, :encrypted_password)
        t.string :encrypted_password, null: false, default: ""
      end
      unless column_exists?(:customers, :reset_password_token)
        t.string :reset_password_token
      end
      unless column_exists?(:customers, :reset_password_sent_at)
        t.datetime :reset_password_sent_at
      end
      unless column_exists?(:customers, :remember_created_at)
        t.datetime :remember_created_at
      end
      # Uncomment if you want to add more columns
      # unless column_exists?(:customers, :sign_in_count)
      #   t.integer :sign_in_count, default: 0, null: false
      # end
      # unless column_exists?(:customers, :current_sign_in_at)
      #   t.datetime :current_sign_in_at
      # end
      # unless column_exists?(:customers, :last_sign_in_at)
      #   t.datetime :last_sign_in_at
      # end
      # unless column_exists?(:customers, :current_sign_in_ip)
      #   t.string :current_sign_in_ip
      # end
      # unless column_exists?(:customers, :last_sign_in_ip)
      #   t.string :last_sign_in_ip
      # end
      # Uncomment if you want to add confirmable columns
      # unless column_exists?(:customers, :confirmation_token)
      #   t.string :confirmation_token
      # end
      # unless column_exists?(:customers, :confirmed_at)
      #   t.datetime :confirmed_at
      # end
      # unless column_exists?(:customers, :confirmation_sent_at)
      #   t.datetime :confirmation_sent_at
      # end
      # unless column_exists?(:customers, :unconfirmed_email)
      #   t.string :unconfirmed_email
      # end
      # Uncomment if you want to add lockable columns
      # unless column_exists?(:customers, :failed_attempts)
      #   t.integer :failed_attempts, default: 0, null: false
      # end
      # unless column_exists?(:customers, :unlock_token)
      #   t.string :unlock_token
      # end
      # unless column_exists?(:customers, :locked_at)
      #   t.datetime :locked_at
      # end
    end

    # Add indexes only if not already present
    unless index_exists?(:customers, :email)
      add_index :customers, :email, unique: true
    end
    unless index_exists?(:customers, :reset_password_token)
      add_index :customers, :reset_password_token, unique: true
    end
    # Uncomment if you want to add more indexes
    # unless index_exists?(:customers, :confirmation_token)
    #   add_index :customers, :confirmation_token, unique: true
    # end
    # unless index_exists?(:customers, :unlock_token)
    #   add_index :customers, :unlock_token, unique: true
    # end
  end
end
