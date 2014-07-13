class UsersController < ApplicationController
  PER_PAGE = 50

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
        .limit((params[:page].to_i + 1) * PER_PAGE)
        .text_search(params[:query])
        .to_a.drop(params[:page].to_i * PER_PAGE)
    else
      repos = []
    end
    render json: repos, each_serializer: UserSerializer, root: "searchResults", meta: {
      page: params[:page]
    }
  end

  protected

  def getUser
    User.where(id: params[:id]).first
  end
end