module FriendshipsHelper

  def friends_request_sent?(user)
    current_user.friendships.find_by(:friend => user)
  end

  def friends?(user)
    current_user.friendships.find_by(:friend => user) && current_user.inverse_friendships.find_by(:user => user)
  end

  def friends_request_received?(user)
    current_user.inverse_friendships.find_by(:user => user)
  end

end
