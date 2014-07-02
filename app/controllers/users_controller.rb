class UsersController < ApplicationController
  def show
    @user = getUser
    if @user.indexed.nil? || Chronic.parse('2 days ago') < @user.indexed
      StarService.delay.importFor(@user.id.to_s)
    end
  end

  def search
    if params[:query].present?
      repos = Repository.in(name: getUser.repos).text_search(params[:query]).to_a
    else
      repos = []
    end
    render json: repos, each_serializer: UserSerializer, root: false
  end

  protected

  def getUser
    User.where(id: params[:id]).first
  end
end