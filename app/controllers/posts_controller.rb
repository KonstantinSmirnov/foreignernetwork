class PostsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create!(post_params)
    redirect_to @user
  end


  def destroy

  end

  private

    def post_params
      params.require(:post).permit(:text, :author_id)
    end

end
