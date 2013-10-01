require 'spec_helper'

describe SessionsController do
  def valid_user_attributes
    {
        :username => "testuser",
        :password => "password",
        :email =>  "testuser@gmail.com",
        :user_type => "user"
    }
  end


  def valid_session
    {
        :user_id => 1
    }
  end


  describe "GET new session" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST create new session" do

    it "Failed authentication due to password mismatch" do
      user = User.create! valid_user_attributes
      post :create, {:username => user.username, :password => "no"}
      session[:user_id].should be_nil
    end
  end

  describe "GET destroy session" do

    it "returns http success" do
      user = User.create! valid_user_attributes
      session[:user_id] = 1
      get :destroy
      #response.should be_success
      response.code.should eq("302")
      session[:user_id].should be_nil
    end
  end
end
