class BatchesController < ApplicationController
	before_action :authenticate_user! 
    load_and_authorize_resource

	#listing the all batches
	def index
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
   
    # update by school admin
	def update
		@batch = Batch.find_by(id: params[:id])
		if @batch.update(batch_params)
			render json: @batch, status: :ok
		else
			render json: { errors: @batch.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private

	def batch_params
		params.require(:batch).permit(:name, :course_id)
	end
end
