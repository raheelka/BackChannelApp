class DeleteAdminSoThatSuperAdminCanBeAdded < ActiveRecord::Migration
  def change
    User.find_by_username("admin").destroy
  end
end
