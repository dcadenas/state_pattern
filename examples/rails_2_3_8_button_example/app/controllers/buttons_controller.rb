class ButtonsController < ApplicationController
  before_filter :load

  def show
  end

  def push
    flash[:notice] = @button.push!
    redirect_to button_path
  end

private

  def load
    @button = Button.first || Button.create!
  end
end

