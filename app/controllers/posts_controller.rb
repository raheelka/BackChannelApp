class PostsController < ApplicationController
  def new
    @post=Post.new
  end

  def create
    @post = current_user.posts.build(params[:post].permit(:content))
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
end
