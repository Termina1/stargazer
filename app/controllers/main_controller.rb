class MainController < ApplicationController
  def index
    if warden.authenticated?
      redirect_to user_path(warden.user)
    end
  end

  def about
  end
end