class PostMailMailer < ApplicationMailer

    def post_confirmation
        @user = params[:user]
        @feed=params[:feed]
        mail(:to => "#{@user.name} <#{@user.email}>", :subject => "Post Confirmation")
     end
end
