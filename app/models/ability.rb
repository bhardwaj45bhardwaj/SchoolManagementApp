# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.school_admin?
      can [:update, :read], User, id: user.id 
      can [:update, :read], School, id: user.school_id 
      can [:create, :update, :read], Course, school_id: user.school_id  # school_admin can update course
      can [:create, :update, :read], Batch, course: {school_id: user.school_id} 
      can [:create, :update, :destroy, :read], Enrollment, batch: {course: {school_id: user.school_id}}
    elsif user.student?
      can [:create, :read], Enrollment, student_id: user.id, batch: {course: {school_id: user.school_id}}
      @batch_ids = user.enrollments.pluck(:batch_id)
      can :batch_students, Batch, id: @batch_ids
    end
  end
end
