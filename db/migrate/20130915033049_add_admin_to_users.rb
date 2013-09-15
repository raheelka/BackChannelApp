class AddAdminToUsers < ActiveRecord::Migration
  def change
    User.create(first_name: "Admin", last_name:"Admin", username: "admin", email: "admin@gmail.com", password: "admin123", password_confirmation:"admin123")
  end
end
