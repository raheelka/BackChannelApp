class UsersController < ApplicationController
  def new
    @user=User.new
  end

  def create
    @user=User.new(params[:user].permit(:first_name, :last_name, :username, :email, :password, :password_confirmation))
    @user.user_type="user"
    if @user.save
      redirect_to log_in_path, :notice => "User Successfully Signed up! Log in to continue"
    else
    render "new"
    end
  end

  def alluserdata
    if current_user
    if current_user.user_type!="admin" && current_user.user_type!="superadmin"
      redirect_to root_url, :notice => "You are not authorized"
    else
      @users=User.all
    end
    else
      redirect_to root_url, :notice => "You are not authorized"
      end

  end

  def createAdmin
    @user=User.new
  end

  def saveAdmin
    @user=User.new(params[:user].permit(:first_name, :last_name, :username, :email, :password, :password_confirmation))
    @user.user_type="admin"
    if @user.save
      redirect_to root_url, :notice => "Admin Successfully Created!"
    else
      render "new"
    end
  end

  def promoteToAdmin
    @user=User.find(params[:id])
    @user.user_type="admin"
    if @user.save
      redirect_to :action => "alluserdata", :notice => "Promoted to Admin!"
    end
  end

  def revokeAdmin
    @user=User.find(params[:id])
    @user.user_type="user"
    if @user.save
      redirect_to :action => "alluserdata", :notice => "Revoked Admin Rights!"
    end
  end

  def viewReport
    # This is to get posts some days back
    require 'date'
    now = Date.today
    ten_days_ago = (now - params[:q].to_i)

    @posts=Post.where({ created_at: ten_days_ago..Time.zone.now.end_of_day})




  end

  def viewReportAj
    # This is to get posts some days back
    require 'date'
    now = Date.today
    ten_days_ago = (now - params[:daysback].to_i)

    @posts=Post.where({ created_at: ten_days_ago..Time.zone.now.end_of_day})

    # Rendering the partial form. Done for ajax loading of this partial inside viewReport.html.erb
    render :partial => "viewReportPar"

   end


  def destroy
    @user= User.find(params[:id])

    moveAllStuffToAnonymousUser(@user.id)

    if(current_user==@user)
      session[:user_id]=nil
      redirect_to root_url
    else
      session[@user.id] = nil   # This should be done by calling the destroy method of sessions controller :(
      redirect_to :action => "alluserdata", :notice => "User successfully deleted!"
    end
      @user.destroy

  end


end
