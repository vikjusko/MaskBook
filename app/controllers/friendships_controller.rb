class FriendshipsController < ApplicationController
  before_action :find_friend, only: [:new, :update] 

  def index
    @users = User.all
  end 

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.create(friend_params) 
    redirect_to friendships_url
    flash[:success] = "Friend request sent!"
  end 

  def show 
  end

  def update
    if current_user.confirm(@friend)
      redirect_to friendships_url
      flash[:success] = "Friend request accepted!"
    else
      render 'new'
    end
  end 

  def destroy
    #if 
    @friendship = Friendship.find_by user_id: params[:friend_id] , friend_id: current_user.id
    p params[:friend_id]
    p current_user.id
    p @friendship
    @friendship.destroy
      #current_user.reject(@friend)
      redirect_to friendships_path 
      flash[:success] = "Friend request denied!"
    # else
    #   render 'new'
    # end
  end

 private

  def friend_params
    params.require(:friendship).permit(:friend_id).merge(user_id: current_user.id)
  end

  def find_friend
    @friend = User.find(params[:friend_id])
  end

end