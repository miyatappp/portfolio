class Admin::PostsController < ApplicationController
 before_action :authenticate_admin!
 
  def index
  @posts = Post.page(params[:page])
   if params[:sort_by].present?
    @posts = eval("@posts.#{params[:sort_by]}")
   else
    @posts = @posts.latest
   end
  end

  def show
  @post = Post.find(params[:id])
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end
  
    def search
    if params[:keyword].present?
      @posts = Post.page(params[:page]).where('sake LIKE ?', "%#{params[:keyword]}%").or(Post.page(params[:page]).where('impression LIKE ?', "%#{params[:keyword]}%"))
    else
      @posts = Post.page(params[:page])
    end
   if params[:prefecture] != "0"
     @posts = @posts.where(prefecture: params[:prefecture])
   end
   if params[:specific].present?
     @posts = @posts.where(specific: params[:specific])
   end 
   if params[:sort_by].present?
    @posts = eval("@posts.#{params[:sort_by]}")
   else
     @posts = @posts.latest
   end
    end
 
end
