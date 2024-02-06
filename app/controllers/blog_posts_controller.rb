class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_blog_post, except: [:index, :new, :create]

  def index
    if user_signed_in?
      @blog_posts = BlogPost.sorted.paginate(page: params[:page], per_page: 2)
    else
      @blog_posts = BlogPost.published.sorted.paginate(page: params[:page], per_page: 2)
    end
  end
  

  def show
    if @blog_post.nil?
      redirect_to root_path, alert: "Blog post not found"
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def new
    @blog_post = BlogPost.new
    @blog_post.published_at = nil
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    existing_post = BlogPost.find_by(title: @blog_post.title)
    if existing_post
      flash[:error] = "A blog post with the same title already exists."
      render :new
    elsif @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end
  

  def edit
    if @blog_post.nil?
      redirect_to root_path, alert: "Blog post not found"
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    if @blog_post.destroy
      redirect_to root_path, notice: "Blog post was successfully deleted."
    else
      redirect_to @blog_post, alert: "Failed to delete blog post."
    end
end


  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :published_at)
  end

  def find_blog_post
    id_or_slug = params[:id]

    if id_or_slug.to_i.to_s == id_or_slug
      # If the parameter is a number, treat it as an ID
      @blog_post = current_user ? BlogPost.find(id_or_slug) : BlogPost.published.find(id_or_slug)
    elsif id_or_slug.present?
      # If the parameter is not a number and is present, treat it as a title
      slug = id_or_slug.parameterize
      @blog_post = current_user ? BlogPost.find_by(slug: slug) : BlogPost.published.find_by(slug: slug)
    else
      # Handle the case when id_or_slug is not present (e.g., show a flash message or redirect)
      redirect_to root_path, alert: "Invalid blog post identifier"
    end
  end
end
