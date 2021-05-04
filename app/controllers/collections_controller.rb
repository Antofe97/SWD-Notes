class CollectionsController < ApplicationController
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
      redirect_to collections_path
    end
  end

  # POST /collections or /collections.json
  def create
    @collection = Collection.new(collection_params)
    @collection.user_id = current_user.id

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: "Collection was successfully created." }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1 or /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to collections_path, notice: "Collection was successfully updated." }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1 or /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url, notice: "Collection was successfully destroyed." }
      format.json { head :no_content }
    end
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
