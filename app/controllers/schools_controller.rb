class SchoolsController < ApplicationController

	before_action :authenticate_user! 
    load_and_authorize_resource

	#listing the all school
	def index
		@schools = School.all
		render json: @schools, status: :ok
	end

    # Create school only by admin
	def create 
		@school = School.new(school_params)
		@school.created_by = current_user.id
		if @school.save
			render json: @school, status: :created
		else
			render json: { errors: @school.errors.full_messages }, status: :unprocessable_entity
		end
	end

	# show school
	def show
		@school = School.find_by(id: params[:id])
		if @school.present?
			render json: @school, status: :ok
		else
			render json: { errors: "School not found" }, status: :unprocessable_entity
		end
	end
   
    # update and create school by admin and school admin
	def update
		@school = School.find_by(id: params[:id])
		@school.created_by = current_user.id if @school.present?
		if @school.update(school_params)
			render json: @school, status: :ok
		else
			render json: { errors: @school.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private

	def school_params
		params.require(:school).permit(:name)
	end


end
