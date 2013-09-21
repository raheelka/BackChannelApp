class UsersController < ApplicationController
  def new
    @user=User.new
  end

  def create
    @user=User.new(params[:user].permit(:first_name, :last_name, :username, :email, :password, :password_confirmation))
    @user.user_type="user"
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
    render "new"
    end
  end

  def alluserdata
    @users=User.all
  end

end
