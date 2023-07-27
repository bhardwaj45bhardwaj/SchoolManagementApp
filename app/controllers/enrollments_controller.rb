class EnrollmentsController < ApplicationController
	before_action :authenticate_user! 
    load_and_authorize_resource
	
	def index
	  # manage all enrollments and as well student and batch wise enrollment listing
	  if current_user.student?
        @enrollments = current_user.enrollments
	  elsif current_user.school_admin?
	  	@enrollments = Enrollment.all
	  end
	  render json: @enrollments, status: :ok
	end
    
    #Enrollment request create by student and school admin as well enroll student into batch and also we can implement for bulk creation
	def create
		if current_user.student?
			@enrollment = current_user.enrollments.new(enrollment_params)
		elsif current_user.school_admin?
			@enrollment = Enrollment.new(enrollment_by_shcool_admin_params)
		end
		@enrollment.created_by = current_user.id
		if @enrollment.save
			render json: @enrollment, status: :created
		else
			render json: { errors: @enrollment.errors.full_messages }, status: :unprocessable_entity
		end
	end
    
    # Update enrollment status by school admin
	def update
       @enrollment = Enrollment.find_by(id: params[:id])
       @enrollment.approved_by = current_user.id if @enrollment.present?
		if @enrollment.update(update_params)
			render json: @enrollment, status: :ok
		else
			render json: { errors: @enrollment.errors.full_messages }, status: :unprocessable_entity
		end
	end
    
    # delete enrollment
	def destroy
       @enrollment = Enrollment.find_by(id: params[:id])
		if @enrollment.destroy
			head :no_content 
		else
			render json: { errors: @enrollment.errors.full_messages }, status: :unprocessable_entity
		end
	end
       

	private

	def enrollment_params
		params.require(:enrollment).permit(:batch_id)
	end

	def update_params
		params.require(:enrollment).permit(:status, :batch_id, :student_id)
	end

	def enrollment_by_shcool_admin_params
		params.require(:enrollment).permit(:batch_id, :student_id)
	end
end
