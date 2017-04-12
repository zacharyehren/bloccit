class FavoriteMailer < ApplicationMailer
  default from: "zachehren@gmail.com"

  #We'll call this method to send an email to users, notifying them that someone has left a comment on one of their favorited posts
  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
