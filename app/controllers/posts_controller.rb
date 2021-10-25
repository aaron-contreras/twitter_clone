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

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:body, :username)
  end
end
