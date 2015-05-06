class NotesController < ApplicationController
  before_action :set_note, only: [:update]
  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html do
          redirect_to course_lesson_path(@note.course, @note.lesson),
          notice: 'Note created successfully.'
        end
      # else
      #   format.html { redirect_to course_lesson_path(@course, @lesson), notice: 'Note creation failed.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html do
          redirect_to course_lesson_path(@note.course, @note.lesson),
          notice: 'Note was successfully updated.'
        end
        # format.json { render :show, status: :ok, location: [@course, @lesson] }
      # else
      #   format.html { render :edit }
      #   format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private
    def set_note
      @note   = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:user_id, :course_id, :lesson_id, :content)
    end
end
