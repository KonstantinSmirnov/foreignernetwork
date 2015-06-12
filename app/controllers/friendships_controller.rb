class FriendshipsController < ApplicationController

  def index

    @friends = []

    current_user.friends.each do |requested|
      current_user.inverse_friends.each do |received|
        if requested == received
          @friends << requested
        end
      end
    end

    #requests you sent
    @friend_requests_sent = current_user.friends.all - @friends

    #requests sent to you
    @friend_requests_received = current_user.inverse_friends.all - @friends

  end


  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      #flash[:success] = "Friend added"
      redirect_to request.referrer
    else
      flash[:danger] = "not saved or this user is already added"
      redirect_to users_path
    end
  end


  #def accept
  #  @friend_to_accept = current_user.inverse_friends.find(params[:id])
  #  @accepted_friendship = current_user.friendships.build(:friend_id => @friend_to_accept.id)
  #  if @accepted_friendship.save
  #    flash[:success] = "Friendship accepted"
  #    redirect_to friends_path
  #  else
  #    flash[:danger] = "Friendship is not accepted"
  #    redirect_to friends_path
  #  end
  #end


  def destroy
    @friendship = current_user.friendships.find_by(user: current_user, friend: params[:id])
    if @friendship.destroy
      #wflash[:success] = "destroyed"
      redirect_to request.referrer

    else
      flash[:danger] = 'can not be destroyed'
      redirect_to friends_path
    end
  end

end
