require 'spec_helper'

def valid_attributes
  {
      :username => "testuser2",
      :password => "password",
      :email =>  "testuser2@gmail.com",
      :user_type => "user"
  }
end

def valid_session
  {
      :user_id => 1    #assumes that there is a first user who is an admin
  }
end


describe UsersController do

  describe "GET new" do
    it "creates new user as @user" do
      get :new, valid_session
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET newAdmin" do
    it "creates new Admin as @user" do
      get :createAdmin, valid_session
      assigns(:user).should be_a_new(User)
    end
  end

  describe "POST create" do
    describe "Validations" do
      it "creates a User" do
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end
      it "assigns a new user as @user" do
        post :create, {:user => valid_attributes}, valid_session
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end
      it "Redirection of new user" do
        post :create, {:user => valid_attributes}, valid_session
        response.should redirect_to(root_url)
      end

    end
  end
  describe "DELETE destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      user2 = User.create(:username => "delete_me", :password => "delete_me", :email => "delete",:user_type =>"user")
      expect {
        delete :destroy, {:id => user2.to_param}, valid_session
      }.to change(User, :count).by(-1)
    end

    end
  end


