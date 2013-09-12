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

    @posts=Post.where(category: params[:s]).all

  end

end
