# frozen_string_literal: true
require "#{Rails.root}/lib/wiki_course_edits"

class DeleteCourseWorker
  include Sidekiq::Worker

  def self.schedule_edits(course:, current_user:)
    perform_async(course.id, current_user.id)
  end

  def perform(course_id, current_user_id)
    course = Course.find(course_id)
    current_user = User.find(current_user_id)
    WikiCourseEdits.new(action: :update_course,
                        course: course,
                        current_user: current_user,
                        delete: true)
  end
end
