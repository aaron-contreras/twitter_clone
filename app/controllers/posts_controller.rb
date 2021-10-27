class PostsController < ApplicationController
  # equivalent to layout
  matestack_app TwitterClone::App

  # GET /posts or /posts.json
  def index
    # @posts = Post.all
    # equivalent to template/view
    render TwitterClone::Pages::Posts::Index
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: {
        message: 'Post was successfully created.'
      }, status: :created
    else
      render json: {
        errors: @post.errors,
        message: 'Post could not be created.'
      }, status: :unprocessable_entity
    end
  end

  def like
    @post = Post.find(params[:id])
    @post.increment(:likes_count)

    if @post.save
      render json: {
        message: 'Post was succesfully liked.'
      }, status: :created
    else
      render json: {
        errors: @post.errors,
        message: 'Post could not be liked.'
      }, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:body, :username)
  end
end
