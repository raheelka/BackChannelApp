class PostsController < ApplicationController
  def new
    @post=Post.new
  end

  def create
    @post = current_user.posts.build(params[:post].permit(:content, :category))
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
  end

  def edit
    @post=Post.find(params[:id])
  end

  def update
       @post=Post.find(params[:id])
      if @post.update(params[:post].permit(:content, :category))
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
        if post.category.upcase.index(params[:s].upcase)        # Doing this to compare without case
          @posts << post
        end
        end
      end
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

    @posts


  end

end
