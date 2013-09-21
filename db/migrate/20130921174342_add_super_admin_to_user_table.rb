class AddSuperAdminToUserTable < ActiveRecord::Migration
  def change
    User.create(first_name: "Super_Admin", last_name:"Super_Admin", username: "superadmin", email: "superadmin@gmail.com", password: "superadmin123", password_confirmation:"superadmin123", user_type: "superadmin")
  end
end
