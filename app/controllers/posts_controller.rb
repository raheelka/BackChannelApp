class PostsController < ApplicationController
  def new
    @post=Post.new
  end

  def create
    @post = current_user.posts.build(params[:post].permit(:title, :content, :category, :tag))
    @post.weight = 1000
    decay_all_posts_by_x(50)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
      render 'post'
    end
  end

  def destroy
   @post= Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  def index
    @posts=Post.order('weight DESC').all
    @comments=Comment.all
  end

  def edit
    @post=Post.find(params[:id])
  end

  def update
       @post=Post.find(params[:id])
      if @post.update(params[:post].permit(:title, :content, :category, :tag))
        flash[:success] = "Post Edited Successfully!"
        redirect_to root_path
      end
  end

  def search

    @comments=Comment.all
    if params[:selectSearch] == "searchContent"
       @posts = Array.new
       Post.all.each do
       |post|
         if post.content.upcase.index(params[:s].upcase)        # Doing this to compare without case
           @posts << post
         end
       end
    elsif  params[:selectSearch] == "searchCategory"
      @posts = Array.new
      Post.all.each do
      |post|
        if post.category
        if post.category.upcase.index(params[:s].upcase)      # Doing this to compare without case
          @posts << post
        end
        end

        if post.tag
          if post.tag.upcase.index(params[:s].upcase)      # Doing this to compare without case
            @posts << post
          end
        end

      end
      @posts=@posts.uniq

    else      # Search by user (For now simply user's first name)
      @posts = Array.new
      User.all.each do
      |user|
          if user.first_name.upcase.index(params[:s].upcase) || user.last_name.upcase.index(params[:s].upcase)        # Doing this to compare without case
            all_posts_of_user = Post.where(user_id: user).all
             all_posts_of_user.each do
               |user_post|
                @posts << user_post
             end
          end

      end
    end




  end

  def votedup

    @alreadyVotedPost=Vote.find_by(:user_id => current_user.id, :post_id => params[:id])

    if @alreadyVotedPost == nil
    @vote=Vote.new
    @vote.post_id = params[:id]
    @vote.user_id = current_user.id
    puts @vote
    @vote.save
    # This will boost the current post being liked by 10 and decay all others by 5
    boost_this_post_by_x(params[:id],10)
    decay_all_posts_by_x_except(params[:id],5)
      #---------------------------------------------
     end
    @upvotes=Vote.find_all_by_post_id(params[:id]).count

    render :text => "<div class='up'></div>"+@upvotes.to_s+" Votes"
  end

  def  votedCommentUp

    @comment=Comment.find(params[:id])

    @alreadyVotedComment=CommentVote.find_by(:user_id => current_user.id, :comment_id => params[:id])


    pid=@comment.post_id

    if @alreadyVotedComment==nil
    @commentVote=CommentVote.new
    @commentVote.comment_id=params[:id]
    @commentVote.user_id=current_user.id
    @commentVote.post_id=pid

    @commentVote.save
    end

    @upVotesComment=CommentVote.find_all_by_comment_id(params[:id]).count

    render :text => "<div class='upComment'></div>"+@upVotesComment.to_s+" Votes"

  end


  def saveComment


    @comment=Comment.new
    @comment.user_id=current_user.id
    @comment.post_id = params[:id].to_i
    @comment.content = params[:comment]
    @comment.save

    boost_this_post_by_x(params[:id].to_i,20)
    decay_all_posts_by_x_except(params[:id].to_i,10)

    redirect_to :action => "index"

  end

  def deleteComment
    @comment= Comment.find(params[:id])
    @comment.destroy
    flash[:notice]="Comment deleted"
    redirect_to :action => "index"

  end

  def editComment
    @comment = Comment.find(params[:id])
  end

  def updateComment
    @comment=Comment.find(params[:id])
    @comment.content=params[:content]
    if @comment.save
    redirect_to :action => "index"
    end

  end

end
