class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :full_name
  helper_method :admin_user
  helper_method :super_admin_user
  helper_method :all_cats

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def full_name
     @full_name = @current_user.first_name + " " + @current_user.last_name
  end

  def admin_user
    @admin_user = User.find_by_user_type("admin")
  end

  def super_admin_user
    @super_admin_user = User.find_by_user_type("superadmin")
  end

  def all_cats
    @all_cats = Array.new
    CategoryRep.all.each do
    |categ|
      if categ.category
       @all_cats << categ.category
      end
    end
    @all_cats
  end

end
