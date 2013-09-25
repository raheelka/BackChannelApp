class CommentsController < ApplicationController

  def update

    @comment=Comment.find(params[:comment][:id])
      @comment.content=params[:comment][:content]
    @comment.save

    redirect_to :controller => "posts" , :action => "index"

  end

end
