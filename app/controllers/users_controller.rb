class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
        @user = User.new
  end
def edit
  @user=User.find(current_user.id)
end

  def create
   
    @user = User.new(user_params)
     if @user.save
      MailsMailer.with(user: @user).welcome_email.deliver
         redirect_to user_path(@user.id)
     else
       render :new
    end
  end
    # POST /feeds or /feeds.json
    def create
      @user= User.new(user_params)
      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: "You have successfully regiter." }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
#-------------------------------------------
  def update
    @user=User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @feed= Feed.find_by user_id: @user.id
  end

  private
  def user_params
  params.require(:user).permit(:name,:email,:password,:password_confirmation,:image,:image_cache)
  end
  
end
