class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email_or_username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to :controller => "posts", :action => "index" , :notice => "Logged in!"
    else
      flash.now.alert = "Invalid Login! "
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end