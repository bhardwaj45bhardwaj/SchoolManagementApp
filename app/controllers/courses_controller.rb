class CoursesController < ApplicationController
	before_action :authenticate_user! 
    load_and_authorize_resource

	#listing the all courses
	def index
		if current_user.admin?
			@courses = Course.all
		elsif current_user.school_admin?
			@courses = Course.where(school_id: current_user.school_id)
		end
		render json: @courses, status: :ok
	end

    # Create Course only by school_admin
	def create 
		@course = Course.new(course_params)
		@course.created_by = current_user.id
		if @course.save
			render json: @course, status: :created
		else
			render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
		end
	end

	# course show
	def show
		@course = Course.find_by(id: params[:id])
		if @course.present?
			render json: @course, status: :ok
		else
			render json: { errors: "Course not found" }, status: :unprocessable_entity
		end
	end
   
    # update by school admin
	def update
		@course = Course.find_by(id: params[:id])
		@course.created_by = current_user.id if @course.present?
		if @course.update(course_params)
			render json: @course, status: :ok
		else
			render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private

	def course_params
		params.require(:course).permit(:name, :school_id)
	end
end
