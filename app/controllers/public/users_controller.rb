class Public::UsersController < ApplicationController

  def show
   @user = User.find(params[:id])
   @following_users = @user.following_users
   @follower_users = @user.follower_users
   @posts = @user.posts.page(params[:page])
   if params[:sort_by].present?
    @posts = eval("@posts.#{params[:sort_by]}")
   else
    @posts = @posts.latest
   end
  end
  
  def bookmarks 
   @user = User.find(params[:id])
   @posts = @user.posts
   bookmarks = Bookmark.where(user_id: @user.id).pluck(:post_id)
   @bookmark_posts = Post.find(bookmarks)
  end
 
  def follows
   @user = User.find(params[:id])
   @posts = @user.posts
   @follows = @user.following_users
  end

  def followers
   @user = User.find(params[:id])
   @posts = @user.posts
   @followers = @user.follower_users
  end
 
  
  def edit
   @user = User.find(params[:id])
   unless @user.id == current_user.id
    redirect_to user_path(current_user.id)
   end
  end
  
  def index
   @users = User.page(params[:page]).latest
  end

  
  def update
   @user = current_user
   if @user.update(user_params)
    redirect_to user_path
   else
    render :edit
   end
  end
  
  def search
   @user = User.find(params[:id])
   if params[:keyword].present?
    @posts = @user.posts.page(params[:page]).where('sake LIKE ?', "%#{params[:keyword]}%").or(@user.posts.page(params[:page]).where('impression LIKE ?', "%#{params[:keyword]}%"))
   else
    @posts = @user.posts.page(params[:page])
   end
    
   if params[:sort_by].present?
    @posts = eval("@posts.#{params[:sort_by]}")
   else
    @posts = @posts.latest
   end
     
   if params[:prefecture] != "0"
    @posts = @posts.where(prefecture: params[:prefecture])
   end
    
   if params[:specific].present?
    @posts = @posts.where(specific: params[:specific])
   end 
  end

  def search_user
   if params[:keyword].present?
    @users = User.page(params[:page]).where('name LIKE ?', "%#{params[:keyword]}%")
   else
    @users = User.page(params[:page])
   end
   if params[:sort_by].present?
    @users = eval("@users.#{params[:sort_by]}")
   else
    @users = @users.latest
   end
  end


private

  def user_params
   params.require(:user).permit(:name,:email)
  end
























end
