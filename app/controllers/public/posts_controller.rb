class Public::PostsController < ApplicationController

  def new
   @post = Post.new
  end
  
  def create
   @post = Post.new(post_params)
   @post.user_id = current_user.id
   if @post.save
    redirect_to post_path(@post.id)
   else
    render :new
   end
  end
  
  def index
   @posts = Post.page(params[:page])
   if params[:sort_by].present?
    @posts = eval("@posts.#{params[:sort_by]}")
   else
    @posts = @posts.latest
   end
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

  def show
   @post = Post.find(params[:id])
   @post_comment = PostComment.new
  end
  
  def destroy
   post = Post.find(params[:id])
   unless post.user.id == current_user.id
    redirect_to root_path
   end
   post.destroy
   redirect_to user_path(current_user.id)
  end

  def edit
   @post = Post.find(params[:id])
   unless @post.user.id == current_user.id
    redirect_to root_path
   end
   @post = Post.find(params[:id])
  end
  
  def update
   @post = Post.find(params[:id])
    if @post.update(post_params)
     redirect_to post_path(@post.id)
    else
     render :edit
    end
  end

private
  def post_params
   params.require(:post).permit(
      :image,      ##写真
      :sake,       ##銘柄
      :specific,   ##特定名称
      :polishing,  ##精米歩合
      :prefecture, ##製造地都道府県
      :impression, ##感想
      :score,      ##点数
      :recommend,  ##おすすめ度・MAX5
      :attack,     ##アタック・口に含んだときの印象の強さ
      :scent,      ##香りの高さ  低い～高い
      :taste,      ##味の濃さ    淡い～濃い
      :sweet,      ##甘辛度      甘い～辛い
      :acidity,    ##酸味        低い～高い
      :bitter,     ##苦味        低い～高い
      :umami,      ##旨味        低い～高い
      :complexity, ##複雑性・クセ低い～高い
      :after_flavor,#アフターフレバー・含み香低い～高い
      :lingering,  ##余韻        短い～長い
      :label,      ##ラベルのおしゃれ度合い 
      :amount,     ##飲んだ数量
      :price,      ##値段
     )
  end
end