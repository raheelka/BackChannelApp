class PostsController < ApplicationController
  def new
    @post=Post.new
  end

  def create
    @post = current_user.posts.build(params[:post].permit(:content, :category, :tag))
    @post.weight = 1000
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
    @posts=Post.all
    @comments=Comment.all
  end

  def edit
    @post=Post.find(params[:id])
  end

  def update
       @post=Post.find(params[:id])
      if @post.update(params[:post].permit(:content, :category, :tag))
        flash[:success] = "Post Edited Successfully!"
        redirect_to root_path
      end
  end

  def search

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

    @vote=Vote.new
    @vote.post_id = params[:id]
    @vote.user_id = current_user.id
    puts @vote
    @vote.save

    @upvotes=Vote.find_all_by_post_id(params[:id]).count

    render :text => "<div class='up'></div>"+@upvotes.to_s+" Votes"
  end

  def saveComment


    @comment=Comment.new
    @comment.user_id=current_user.id
    @comment.post_id = params[:id].to_i
    @comment.content = params[:comment]
    @comment.save

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
