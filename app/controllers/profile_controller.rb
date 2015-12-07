class ProfileController < ApplicationController

  def show
  end

  def edit
  end

  def update
    current_user.name = params[:name]
    current_user.save!
    render action: 'show'
  end

end