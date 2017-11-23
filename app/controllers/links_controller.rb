class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.create(link_params)
    render :new
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
