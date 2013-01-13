require 'net/https'
require 'uri'
require 'json'

class SlcResource
  # hardcode some paths for resources we can use in our quick prototype
  STUDENTS_URI = '/sections/88c701d291e11e2d17b9554412878cc9bc7d51e6_id/studentSectionAssociations/students'
  STUDENT_ASSESSMENTS_URI = '/students/92796262ab7771c8ab6e577b85a700cf64902a76_id/studentAssessments'
  TEACHER_URI = '/staff/4069feb780f3a69b7d39cfea94f5728600152633_id'

  def self.fetch_resource(uri, token)
    clean_uri = uri.sub(/^\//, '')

    uri = URI.parse("#{Rails.application.config.REST_URL}/#{clean_uri}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    request.add_field("Content-Type", "application/vnd.slc+json")
    request.add_field("Accept", "application/vnd.slc+json")
    request.add_field("Authorization", "bearer #{token}")

    response = http.request(request)
    JSON.parse(response.body)
  end

  def self.send_message_to_teacher(token, message, teacherId)

    teacherId ||= "4069feb780f3a69b7d39cfea94f5728600152633_id" #Amy Kopel

    data = {
      "studentId" => "92796262ab7771c8ab6e577b85a700cf64902a76_id",
      "timeSent" => Time.now.to_s,
      "message" => message
    }

    # we're using /staff for purposes of demo, since this IT administrator has access to write data
    uri = "/staff/#{teacherId}/custom"

    post(uri, token, data)

  end

  def self.fetch_parent_comment(token, teacherId)
    teacherId ||= "4069feb780f3a69b7d39cfea94f5728600152633_id" #Amy Kopel
    uri = "/staff/#{teacherId}/custom"

    fetch_resource(uri, token)
  end

  def self.post(uri, token, data)
    clean_uri = uri.sub(/^\//, '')
    uri = URI.parse("#{Rails.application.config.REST_URL}/#{clean_uri}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.request_uri)
    request.add_field("Content-Type", "application/vnd.slc+json")
    request.add_field("Accept", "application/vnd.slc+json")
    request.add_field("Authorization", "bearer #{token}")

    request.body = data.to_json
    response = http.request(request)
  end


  # parent and/or teacher logs in --> magic --> obtain students
  def self.fetch_students(token)

    # path for a specific set of students

    fetch_resource(STUDENTS_URI, token)
  end

  def self.fetch_student_assessments(student_id, token)
    fetch_resource(STUDENT_ASSESSMENTS_URI, token)
  end

  def self.fetch_teacher(staff_id, token)
    fetch_resource(TEACHER_URI, token)
  end
end
