class UsersController < ApplicationController
  def show
    @user = getUser
    if @user.indexed.nil? || Chronic.parse('2 days ago') < @user.indexed
      StarService.delay.importFor(@user.id.to_s)
    end
  end

  def reindex
    user = getUser
    if Chronic.parse('5 minutes ago') < user.indexed
      render json: {error: "You're trying to reindex too often"}
    else
      user.update_attribute :indexed, Time.now
      StarService.delay.importFor(user.id.to_s)
      render json: {ok: true}
    end
  end

  def search
    if params[:query].present?
      repos = Repository.in(name: getUser.repos)
        .limit((params[:page].to_i + 1) * 100)
        .text_search(params[:query])
        .to_a.drop(params[:page].to_i * 100)
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