class UsersController < ApplicationController
  def show
  end

  def search
    repos = Repository.in(name: user.repos).text_search(params[:query]).to_a
    render json: repos, each_serializer: UserSerializer
  end

  protected

  def user
    User.where(id: params[:id]).first
  end
end