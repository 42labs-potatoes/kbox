class HomeController < ApplicationController

  def index
    @groups = Group.where(public: true)
  end

  def search
    find_groups(params[:query])
    render 'index'
  end

  private
  # def set_public_groups
  #   @groups = Group.where(public: true)
  # end

  def find_groups(query)
    @groups = Group.where("name LIKE ?", "%#{query}%")
  end

end
