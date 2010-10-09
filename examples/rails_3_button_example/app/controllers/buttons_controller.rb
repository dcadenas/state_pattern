class ButtonsController < ApplicationController
  before_filter do
    @button = Button.first || Button.create!
  end

  def show
  end

  def push
    flash[:notice] = @button.push!
    redirect_to button_path
  end
end
