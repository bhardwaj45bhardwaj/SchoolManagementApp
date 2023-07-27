class UsersController < ApplicationController
	before_action :authenticate_user! 
    load_and_authorize_resource

	# List all users
	def index
		@users = User.all
		render json: @users, status: :ok
	end
    
    #Create schooladmin by admin
	def create 
		@user = User.new(user_params)
		@user.created_by = current_user.id
		if @user.save
			render json: @user, status: :created
		else
			render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
		end
	end
    
    # individual user details
	def show
		@user = User.find_by(id: params[:id])
		if @user.present?
			render json: @user, status: :ok
		else
			render json: { errors: "User not found" }, status: :unprocessable_entity
		end
	end
    
    #get request for student can see students from batch wise
	def batch_students
		@users = current_user.get_students_by_batch(params[:batch_id])
		render json: @users, status: :ok
	end


	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :role_id)
	end

	
end
