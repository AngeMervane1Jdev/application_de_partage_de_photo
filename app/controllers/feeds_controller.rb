class FeedsController < ApplicationController
  before_action :set_feed, only: [ :show ,:edit ,:update ,:destroy ]

  # GET /feeds or /feeds.json
  def index
    @feeds = Feed.all
    @user=User.all
  end

  def favorites_list
    @feeds=Feed.where.not(fovorite_of_user_id: nil)
    @favorites=[]
    @feeds.each do |feed|
      if(feed.fovorite_of_user_id.include?(current_user.id))
      @favorites+=[feed]
      end
    end
  end


  # GET /feeds/1 or /feeds/1.json
  def show
    @feed = Feed.find(params[:id])
  end

  #define a favorite
 def make_it_as_my_favorite
    @feed=Feed.find params[:id]
    @favorites=@feed.fovorite_of_user_id+[current_user.id]
    @feed.update(fovorite_of_user_id:@favorites)
    redirect_to feeds_path
 end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit

  end

  # POST /feeds or /feeds.json
  def create
    @feed = Feed.new(feed_params)
    @feed.user_id=current_user.id
    respond_to do |format|
      if @feed.save
        PostMailMailer.with(user:current_user,feed:@feed).post_confirmation.deliver
        format.html { redirect_to @feed, notice: "We have sent to you an email.Please confirm the post !!" }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1 or /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1 or /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def confirm
    @feed = Feed.new(feed_params)
    render :new if @feed.invalid?
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    private
    def feed_params
      params.require(:feed).permit(:image, :image_cache,:content, :user_id)
    end
end
