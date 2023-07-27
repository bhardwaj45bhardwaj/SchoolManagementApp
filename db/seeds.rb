# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.find_or_create_by({ name: 'Admin', description: 'Can read create and update SchoolAdmin, School' })
Role.find_or_create_by({ name: 'SchoolAdmin', description: 'Can update school, create course and batch' })
Role.find_or_create_by({ name: 'Student', description: 'Can raise enroll requst and read other batch student and their progress' })
