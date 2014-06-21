class SessionsController < ApplicationController
  def create
    warden.authenticate! :github_strategy
    redirect_to user_path(warden.user)
  end
end