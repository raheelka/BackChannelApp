class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :full_name
  helper_method :admin_user
  helper_method :super_admin_user
  helper_method :all_cats
  helper_method :number_of_votes_for_post
  helper_method :all_who_voted

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def full_name
     @full_name = @current_user.first_name + " " + @current_user.last_name
  end

  def admin_user
    if current_user.user_type=="admin"
    @admin_user = current_user
    else
      @admin_user=nil
      end
  end

  def super_admin_user
    if current_user.user_type=="superadmin"
    @super_admin_user = current_user
    else
      @super_admin_user=nil
      end
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

  def number_of_votes_for_post(post)
    @voteCount=Vote.find_all_by_post_id(post).count
  end

  def all_who_voted(post)
    @allWhoVoted= Vote.where(:post_id => post)
    allVoters =String.new

    @allWhoVoted.each do |voter|
       allVoters= allVoters+User.find(voter.user_id).first_name+"||"
    end

    allVoters.to_s

  end

end
