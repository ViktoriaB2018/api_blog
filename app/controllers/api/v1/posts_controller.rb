class Api::V1::PostsController < Api::V1::BaseController
  def create
    form = PostForm.new(ip: request.remote_ip, **post_params)

    if form.save
      render_success()
    else
      render_errors()
    end
  end

  private

  def post_params
    params.permit!.to_h.symbolize_keys
  end
end
