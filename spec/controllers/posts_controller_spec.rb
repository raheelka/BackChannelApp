require 'spec_helper'

describe PostsController do
  def valid_post_attributes
    {
        :content => "Test Post!",
        :user_id => 1
    }
  end
  def invalid_post_attributes
    {
        :content => "Testttiiinnnnnnnnnnnnnggggggggggggggggggggggggggggggggggggggggggggggggggggggg  Invalidddddddddddddddddddddddddddddddddddddddddddddddddddddd !"
    }
  end

  def valid_user_attributes
    {
        :username => "testuser",
        :password => "testuser123",
        :email =>  "testuser@gmail.com",
        :user_type => "user"
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PostsController. Be sure to keep this updated too.
  def valid_session
    {
        :user_id => 1
    }
  end

  def valid_comment_attributes
    {
        :user_id =>1,
        :post_id =>1,
        :content => "Test Comments!"
    }
  end

  describe "GET index" do
    it " All posts as @posts" do
      User.create! valid_user_attributes
      post = Post.create! valid_post_attributes
      get :index, {}, valid_session
      assigns(:posts).should eq([post])
    end
  end

  describe "GET show" do
    it "Requested post as @post" do
      User.create! valid_user_attributes
      post = Post.create! valid_post_attributes
      get :index, {:id => post.to_param}, valid_session
      assigns(:posts).should eq([post])
    end
  end

  describe "GET new" do
    it "new post as @post" do
      User.create! valid_user_attributes
      get :new, {}, valid_session
      assigns(:post).should be_a_new(Post)
    end
  end

  describe "GET edit" do
    it "Editing requested post as @post" do
      User.create! valid_user_attributes
      post = Post.create! valid_post_attributes
      get :edit, {:id => post.to_param}, valid_session
      assigns(:post).should eq(post)
    end
  end

  describe "POST create" do
    describe "valid parameters" do
      it "creates Post" do
        User.create! valid_user_attributes
        expect {
          post :create, {:post => valid_post_attributes}, valid_session
        }.to change(Post,:count).by(1)
      end
      it "New post as @post" do
        User.create! valid_user_attributes
        post :create, {:post => valid_post_attributes}, valid_session
        assigns(:post).should be_a(Post)
        assigns(:post).should be_persisted
      end
      it "redirects to the created post" do
        User.create! valid_user_attributes
        post :create, {:post => valid_post_attributes}, valid_session
        response.should redirect_to(all_post_path)
      end
    end





  end



  describe "PUT update" do
    describe "Validations" do
      it "Assigns updated post @post" do
        User.create! valid_user_attributes
        post = Post.create! valid_post_attributes
        put :update, {:id => post.to_param, :post => valid_post_attributes}, valid_session
        assigns(:post).should eq(post)
      end

      it "Redirection" do
        User.create! valid_user_attributes
        post = Post.create! valid_post_attributes
        put :update, {:id => post.to_param, :post => valid_post_attributes}, valid_session
        response.should redirect_to(:action => "index")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested post" do
      User.create! valid_user_attributes
      post = Post.create! valid_post_attributes
      expect {
        delete :destroy, {:id => post.to_param}, valid_session
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      User.create! valid_user_attributes
      post = Post.create! valid_post_attributes
      delete :destroy, {:id => post.to_param}, valid_session
      response.should redirect_to(:action => "index")
    end
  end


  describe "GET Comments index" do
    it "assigns comments @comments" do
      User.create! valid_user_attributes
      Post.create! valid_post_attributes
      comment = Comment.create! valid_comment_attributes
      get :index, {}, valid_session
      assigns(:comments).should eq([comment])
    end
  end

  describe "GET Comments show" do
    it "shows requested comment@comment" do
      User.create! valid_user_attributes
      Post.create! valid_post_attributes
      comment = Comment.create! valid_comment_attributes
      get :index, {:id => comment.to_param}, valid_session
      assigns(:comments).should eq([comment])
    end
  end


  describe "DELETE Comments destroy" do
    it "destroys the requested comment" do
      User.create! valid_user_attributes
      Post.create! valid_post_attributes
      comment = Comment.create! valid_comment_attributes
      expect {
        delete :deleteComment, {:id => comment.to_param}, valid_session
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the comments list" do
      User.create! valid_user_attributes
      Post.create! valid_post_attributes
      comment = Comment.create! valid_comment_attributes
      delete :deleteComment, {:id => comment.to_param}, valid_session
      response.should redirect_to(:action => "index")
    end
  end


end






















