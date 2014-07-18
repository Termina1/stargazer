class Admin::AdminController < ApplicationController

  before_action :check_admin

  def check_admin
    redirect_to '/' unless warden.user[:admin].present?
  end

  def index
    @users = StarService.get_indexed_stars
  end

  def user
    @usera = StarService.get_indexed_stars_by_user(params[:name])
  end
end