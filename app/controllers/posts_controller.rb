class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc)
    @new_posts=Post.order(created_at: :desc).limit(5)
    @author = Author.first
  end

  def show
    set_post
  end

  def new
    # Postモデルのインスタンスを生成
    @post = Post.new
  end

  def create
    # Postモデルのインスタンスを生成(ストロングパラメータでデータを取得)
    # saveする
    # showページにリダイレクト
    @post = Post.new(post_params)
    @post.save
    redirect_to @post
  end

  def edit    
    set_post
  end

  def update
    set_post
    @post.update(post_params)
    redirect_to edit_post_path

  end

  def destroy
    set_post
    @post.destroy
    redirect_to posts_path
  end

  # プライベートメソッドでストロングパラメータを作成
  private

  def post_params
    params.require(:post).permit(:title, :body, :category)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end