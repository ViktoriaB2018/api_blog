class Api::V1::PostsController < Api::V1::BaseController
  before_action :set_post, only: :rate

  def create
    @form = PostForm.new(ip: request.remote_ip.to_s, **post_params)

    if @form.save
      render_success(@form.post)
    else
      render_errors(@form)
    end
  end

  def top
    @posts = Post.top(params[:count].to_i)

    render_success(@posts.to_a)
  end

  def rate
    result = PostRater.run(post: @post, rate: params[:rate])

    if result.success?
      render_success(result.response)
    else
      render_errors(result.response)
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.permit!.to_h.symbolize_keys
  end
end
