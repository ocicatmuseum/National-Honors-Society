class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts, :force => true do |t|
      t.string      :name, :surname, :email, :salt, :crypted_password, :role, :modules
      t.timestamps
    end

    # I'll create the first account
    Account.create({:email => "swanyboy4@gmail.com", 
                    :name => "Michael", 
                    :surname => "Swan",
                    :password => "blackbelt1", 
                    :password_confirmation => "blackbelt1", 
                    :role => "administrator" })
  end

  def self.down
    drop_table "accounts"
  end
end
