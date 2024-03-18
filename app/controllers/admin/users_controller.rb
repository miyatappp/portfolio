class Admin::UsersController < ApplicationController
 def index
  @users = User.page(params[:page]).latest
 end
 
  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path
  end

 def show
   @user = User.find(params[:id])
   @posts = @user.posts.page(params[:page])
   if params[:sort_by].present?
    @posts = eval("@posts.#{params[:sort_by]}")
   else
    @posts = @posts.latest
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
 
 
end