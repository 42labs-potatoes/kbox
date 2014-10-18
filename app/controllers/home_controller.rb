class HomeController < ApplicationController
  before_action :set_public_groups

  def index
  end

  def search
    target = jump_to(params[:query])
    if target
      redirect_to group_url(target)
    else
      flash[:notice] = "There is no group named '#{params[:query]}'"
      render 'index'
    end
  end

  private
  def set_public_groups
    @public_groups = Group.where(public: true)
  end

  def jump_to(query)
    @target_group = Group.find_by(name: query)
  end

end
