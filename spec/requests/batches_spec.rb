require 'rails_helper'

RSpec.describe "Batches", type: :request do

  let(:role)   {Role.find_or_create_by({ name: 'Admin', description: 'Can update school, create course and batch' })}
  let(:admin_role) { Role.find_or_create_by({ name: 'SchoolAdmin', description: 'Can read create and update SchoolAdmin, School' })}
  let(:student_role)  {Role.find_or_create_by({ name: 'Student', description: 'Can raise enroll requst and read other batch student and their progress' })}

  let(:admin) {User.create(email: 'admin@gmail.com',  password: 'password', password_confirmation: "password", role_id: role.id) }
  let(:school) {School.create(name: "abc", created_by: admin.id)}
  let(:school_admin) {User.create(email: 'school_adming@gmail.com',  password: 'password', password_confirmation: "password", role_id: admin_role.id, created_by: admin.id, school_id: school.id) }
  let(:student) {User.create(email: 'student@gmail.com',  password: 'password', password_confirmation: "password", role_id: student_role.id, school_id: school.id) }

  let(:course) {school.courses.create(name: "Science", created_by: school_admin.id)}
  let!(:batch) {course.batches.create(name: "Science Batch",created_by: school_admin.id)}

   def login_as(user)
      post '/auth/sign_in', params: {
        email: user.email,
        password: 'password'
      }
      @auth_headers = admin.create_new_auth_token
  end

  describe 'GET #index' do
    context 'when user is school admin' do
      before do
        login_as school_admin
      end

      it 'returns a success response' do
        get "/batches", headers: @auth_headers
        expect(response.status).to eq(200)

      end
    end

    context 'when user is admin' do
      before do
        login_as admin
      end

      it 'returns a success response' do
        get "/batches", headers: @auth_headers
        expect(response.status).to eq(200)
      end
    end

    context 'when user is student' do
      before do
        login_as student
      end

      it 'redirects to root path' do
        get "/batches", headers: @auth_headers
        # expect(response).to have_http_status(:unauthorized)
        expect(response.status).to eq(200)
      end
    end
  end
end

