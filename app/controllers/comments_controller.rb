class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.user = User.first #TODO: fix after authentication

    if @comment.save
      flash[:notice] = 'The comment was added.'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end