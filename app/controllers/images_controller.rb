class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :delete]

  def index
    @images = Docker::Image.all
  end

  def add
  end

  def pull
    image = Docker::Image.create('fromImage' => params[:name])
    redirect_to action: 'index'
  end

  def delete
    @image.remove(:force => true)
    redirect_to action: 'index'
  end

  def show
  end


  private
    def set_image
      @image = Docker::Image.get(params[:id])
    end
end
