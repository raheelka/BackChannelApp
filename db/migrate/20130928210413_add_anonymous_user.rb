class AddAnonymousUser < ActiveRecord::Migration
  def change
    User.create(first_name: "Anonymous", last_name:"User", username: "anonymous", email: "anonymous@gmail.com", password: "anonymous", password_confirmation:"anonymous", user_type: "user")
  end
end
