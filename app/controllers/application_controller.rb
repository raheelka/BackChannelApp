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
  helper_method :number_of_comments_for_post
  helper_method :all_who_voted
  helper_method :all_who_commented
  helper_method :boost_this_post_by_x
  helper_method :decay_all_posts_by_x_except
  helper_method :decay_all_posts_by_x
  helper_method :alreadyVotedForPost
  helper_method :alreadyVotedForComment
  helper_method :moveAllStuffToAnonymousUser
  helper_method :findMaxWeight


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

  def number_of_comments_for_post(post)
    @commentCount=Comment.find_all_by_post_id(post).count
  end

  def all_who_voted(post)
    @allWhoVoted= Vote.where(:post_id => post)
    allVoters =String.new

    @allWhoVoted.each do |voter|
       allVoters= allVoters+User.find(voter.user_id).first_name+"##"
    end

    allVoters.to_s

  end

  def all_who_commented(post)
    @allWhoCommented= Comment.where(:post_id => post)
    allCommenters =String.new

    @allWhoCommented.each do |commentor|
      allCommenters= allCommenters+User.find(commentor.user_id).first_name+"##"
    end

    allCommenters.to_s

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

  def moveAllStuffToAnonymousUser(user)

    @anonymousUser=User.find_by(:username => "anonymous")

    Post.all.each do |post|
      if (post.user_id==user)
       post.user_id=@anonymousUser.id
       post.save
      end
    end

    Comment.all.each do |comment|
      if(comment.user_id==user)
        comment.user_id=@anonymousUser.id
        comment.save
      end
    end

    Vote.all.each do |vote|
      if(vote.user_id==user)
        vote.user_id=@anonymousUser.id
        vote.save
      end
    end

    CommentVote.all.each do |commentVote|
      if(commentVote.user_id==user)
        commentVote.user_id=@anonymousUser.id
        commentVote.save
      end
    end


  end

  def findMaxWeight()
    max =0
    if(Post.count > 0)
    Post.all.each  do |post|
      if(post.weight > max)
        max= post.weight
      end
    end
    max = max+10
  else
    max=1000
    end
    return max

  end

end
