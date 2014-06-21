class UsersController < ApplicationController
  def show
  end

  def search
    if params[:query].present?
      repos = Repository.in(name: user.repos).text_search(params[:query]).to_a
    else
      repos = []
    end
    render json: repos, each_serializer: UserSerializer, root: false
  end

  protected

  def user
    User.where(id: params[:id]).first
  end
end