class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      'ok'
    else
      render json: @link.errors.full_messages.join('. '),
             status: :unprocessable_entity
    end
  end

  def show
    link = Link.find_by shorten: params[:id]
    return not_found_page unless link

    redirect_to link.original
  end

  private

  def link_params
    params.require(:link).permit(:original)
  end

  def not_found_page
    render file: Rails.root.join('public', '404.html'), status: 404
  end
end
