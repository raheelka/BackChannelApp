class PostsController < ApplicationController
  def new
    @post=Post.new
  end

  def create
    @post = current_user.posts.build(params[:post].permit(:title, :content, :category, :tag))
    @post.weight = findMaxWeight()
    if @post.save
      flash[:success] = "Post created!"
      redirect_to :action => "index"
    else
      render 'post'
    end
  end

  def destroy
   @post= Post.find(params[:id])
    @post.destroy
   redirect_to :action => "index"
  end

  def index
    @posts=Post.order('weight DESC').all
    @comments=Comment.order('created_at').all
  end

  def edit
    @post=Post.find(params[:id])
  end

  def update
       @post=Post.find(params[:id])
      if @post.update(params[:post].permit(:title, :content, :category, :tag))
        flash[:success] = "Post Edited Successfully!"
        redirect_to :action => "index"
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
         if post.title
            if post.title.upcase.index(params[:s].upcase)
              @posts << post
            end
         end
       end

       Comment.all.each do |comment|                          # Searches by comment wohoooo!!! :)
         if comment.content.upcase.index(params[:s].upcase)
           @posts << comment.post
         end
       end

       @posts=@posts.uniq

    elsif  (params[:selectSearch] == "searchCategory")
      @posts = Array.new
      Post.all.each do
      |post|
        if post.category
        if post.category.upcase.index(params[:s].upcase)      # Doing this to compare without case
          @posts << post
        end
        end

      end
      @posts=@posts.uniq

    elsif  (params[:selectSearch] == "searchTag")
      @posts = Array.new
      Post.all.each do
         |post|
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
          if user.first_name.upcase.index(params[:s].upcase) || user.last_name.upcase.index(params[:s].upcase) || user.username.upcase.index(params[:s].upcase)      # Doing this to compare without case
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
    # This will boost the current posts weight by the maxweight+5
    boost_weight=findMaxWeight - Post.find(@vote.post_id).weight + 5
    boost_this_post_by_x(params[:id],boost_weight)

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

    boost_weight=findMaxWeight-Post.find(@comment.post_id).weight+5
    boost_this_post_by_x(params[:id].to_i,boost_weight)


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

  def searchAuto

    result= Array.new

    if(params[:searchType]!="searchUser")
    Post.all.each do |post|
      if(params[:term])

        if(params[:searchType]=="searchTag")
          if post.tag.upcase.index(params[:term].upcase)
            result << post.tag
          end
        end

        if(params[:searchType]=="searchCategory")
          if post.category.upcase.index(params[:term].upcase)
            result << post.category
          end
        end
      end
    end
    end

    if(params[:searchType]=="searchUser")
      User.all.each do |user|
        if(params[:term])
          if user.first_name.upcase.index(params[:term].upcase)
            result << user.first_name
          end
        end
      end
    end

    result=result.uniq
    respond_to do |format|
      format.html
      format.json { render :json => result.to_json }
    end

  end

end
