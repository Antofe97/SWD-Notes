class NotesController < ApplicationController
  def index
      @notes = Note.where(user_id: current_user.id)
  end

  def user_notes
    @notes = Note.where(user_id: params[:id])
  end

  def show
    @note = Note.find(params[:id])
    if @note.user_id == current_user.id || is_admin?

    else 
      redirect_to notes_path
    end
  end


  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    
    @note.user_id = current_user.id

    if @note.save
      redirect_to @note
    else
      render :new
    end
  end

  def edit
    @note = Note.find(params[:id])
    if @note.user_id == current_user.id || is_admin?

    else
      redirect_to notes_path
    end
  end

  def update
    @note = Note.find(params[:id])

    if @note.update(note_params)
      redirect_to @note
    else
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    redirect_to notes_path
  end

  private
    def note_params
      params.require(:note).permit(:title, :body, :image, :user_id)
    end
  
end
