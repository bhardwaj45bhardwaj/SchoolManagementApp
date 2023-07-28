class BatchesController < ApplicationController
	before_action :authenticate_user! 
    load_and_authorize_resource

	#listing the all batches
	def index
		if current_user.admin?
			@batches = Batch.all
		elsif current_user.school_admin?
			@batches = Batch.where(school_id: current_user.school_id)
		end
		@batches = Batch.all
		render json: @batches, status: :ok
	end

    # Create batch only by school_admin
	def create 
		@batch = Batch.new(batch_params)
		@batch.created_by = current_user.id
		if @batch.save
			render json: @batch, status: :created
		else
			render json: { errors: @batch.errors.full_messages }, status: :unprocessable_entity
		end
	end

	# show school
	def show
		@batch = Batch.find_by(id: params[:id])
		if @batch.present?
			render json: @batch, status: :ok
		else
			render json: { errors: "Batch not found" }, status: :unprocessable_entity
		end
	end
   
    # update by school admin
	def update
		@batch = Batch.find_by(id: params[:id])
		if @batch.update(batch_params)
			render json: @batch, status: :ok
		else
			render json: { errors: @batch.errors.full_messages }, status: :unprocessable_entity
		end
	end

	#get request for student can see students from batch wise
	def batch_students
		@studenst = current_user.get_students_by_batch(params[:id])
		if @studenst.present?
			render json: @studenst, status: :ok
		else
			render json: { errors: "Students not found" }, status: :unprocessable_entity
		end
	end

	private

	def batch_params
		params.require(:batch).permit(:name, :course_id)
	end
end
