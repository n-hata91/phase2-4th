class RelationshipsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to request.referer
  end
end
