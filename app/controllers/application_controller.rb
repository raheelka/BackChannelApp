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
  helper_method :boost_this_post_by_x
  helper_method :decay_all_posts_by_x_except
  helper_method :decay_all_posts_by_x
  helper_method :alreadyVotedForPost
  helper_method :alreadyVotedForComment

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
       allVoters= allVoters+User.find(voter.user_id).first_name+"##"
    end

    allVoters.to_s

  end

  def decay_all_posts_by_x_except(post_id,x)
    @allPostsToDecay=Post.all
    @allPostsToDecay.each do |thisPost|
      if(thisPost.id!=post_id)
        thisPost.weight=thisPost.weight-x
        thisPost.save
      end

    end
  end

  def boost_this_post_by_x(post_id,x)
    @thisPostToBoost=Post.find(post_id)
    @thisPostToBoost.weight=@thisPostToBoost.weight+x
    @thisPostToBoost.save
  end

  def decay_all_posts_by_x(x)
    @allPostsToDecay=Post.all
    @allPostsToDecay.each do |thisPost|
      thisPost.weight=thisPost.weight-x
      thisPost.save
    end
  end

  def alreadyVotedForPost(user,post)
     @voter=Vote.find_by(:user_id => user, :post_id => post)
  end

  def alreadyVotedForComment(user,comment)
    @voterForComment=CommentVote.find_by(:user_id => user, :comment_id =>comment)
  end

end
