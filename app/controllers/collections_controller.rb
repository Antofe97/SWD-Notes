class CollectionsController < ApplicationController
  add_flash_types :danger, :info, :warning, :success, :notice

  before_action :set_collection, only: %i[ show edit update destroy ]
  before_action :admin_permission, only: [:user_collections]

  # GET /collections or /collections.json
  def index
    @collections = Collection.where(user_id: current_user.id)
  end

  #admin_management
  def user_collections
    @collections = Collection.where(user_id: params[:id])
  end

  # GET /collections/1 or /collections/1.json
  def show
    @collection = Collection.find(params[:id])
    if @collection.user_id == current_user.id || is_admin?

    else 
      flash[:danger] = "Unauthorized" 
      redirect_to collections_path
    end

  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
    @collection = Collection.find(params[:id])
    if @collection.user_id == current_user.id || is_admin?

    else 
      flash[:danger] = "Unauthorized" 
      redirect_to collections_path
    end
  end

  # POST /collections or /collections.json
  def create
    @collection = Collection.new(collection_params)
    @collection.user_id = current_user.id

    if @collection.save
      flash[:success] =  "Collection was successfully created."
      redirect_to @collection
    end
    
  end

  # PATCH/PUT /collections/1 or /collections/1.json
  def update
      if @collection.update(collection_params)
        flash[:info] =  "Collection was successfully updated."
        redirect_to collections_path
      end
  end

  # DELETE /collections/1 or /collections/1.json
  def destroy
    @collection.destroy
    flash[:danger] = "The collection was successfully destroyed." 
    redirect_to collections_url 

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def collection_params
      params.require(:collection).permit(:name, :user_id)
    end
end
