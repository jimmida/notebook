class EnrollmentsController < ApplicationController
  before_action :set_courses, only: [:index]

  def index
    @enrollments = current_user.enrollments
  end

  def show
  end

  def create
    @enrollment = Enrollment.new
    @enrollment.user_id   = current_user.id
    @enrollment.course_id = params[:course_id]

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to enrollments_url, notice: 'Course was successfully registered.' }
        format.json { render :show, status: :created, location: @enrollment }
      else
        format.html { redirect_to enrollments_url, notice: 'Course failed to register.' }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @enrollment = Enrollment.find(params[:id])
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to enrollments_url, notice: "Course was successfully unregistered." }
      format.json { head :no_content }
    end
  end

  private
  def set_courses
    @courses = current_user.courses
  end
end
