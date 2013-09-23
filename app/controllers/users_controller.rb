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
    if current_user.user_type!="admin" && current_user.user_type!="superadmin"
      redirect_to root_url, :notice => "You are not authorized"
    else
      @users=User.all
    end

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

  def promoteToAdmin
    @user=User.find(params[:id])
    @user.user_type="admin"
    if @user.save
      redirect_to root_url, :notice => "Promoted to Admin!"
    end


  end

  def viewReport
    @posts=Post.all
  end


  def destroy
    @user= User.find(params[:id])
    if(current_user==@user)
    session[:user_id]=nil
    else
    session[@user.id] = nil   # This should be done by calling the destroy method of sessions controller :(
    end
    @user.destroy
    redirect_to root_path, :notice => "User deleted!"
  end


end
