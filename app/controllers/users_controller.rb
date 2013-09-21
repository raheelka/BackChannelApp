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

  def createAdmin
    @user=User.new
  end

  def saveAdmin
    @user=User.new(params[:user].permit(:first_name, :last_name, :username, :email, :password, :password_confirmation))
    @user.user_type="admin"
    if @user.save
      redirect_to root_url, :notice => "Admin Created!"
    else
      render "new"
    end
  end


  def destroy
    @user= User.find(params[:id])
    @user.destroy
    redirect_to root_path, :notice => "User deleted!"
  end


end
