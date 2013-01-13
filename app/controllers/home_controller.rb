class HomeController < ApplicationController
  def index
  end

  def login
    if session[:token].nil?
      redirect_to get_request_token_uri(), :status => 303
    else
      redirect_to :secure_home
    end
  end

  def logout
    reset_session
    redirect_to :root
  end

  def oauth
    if session[:token].nil?
      session[:token] = get_access_token(params['code'])
    end

    redirect_to :secure_home
  end

  def student
    if session[:token].nil?
      session[:token] = get_access_token(params['code'])
    end
    teacher_json = SlcResource.fetch_teacher(nil, session[:token])["name"]
    student_json = SlcResource.fetch_students(session[:token])[0]
    @teacher_last_name = teacher_json["lastSurname"]
    @teacher_full_name = "#{teacher_json['personalTitlePrefix']}. #{teacher_json['firstName']} #{teacher_json['lastSurname']}"

    student_json = SlcResource.fetch_students(session[:token])[0]
    student_name_obj = student_json["name"]
    @student_name = "#{student_name_obj['firstName']} #{student_name_obj['lastSurname']}"

    @title = "Reading"
    @reading_level = "G"
    @description = "Area of focus:"
    @focus_area = "Fluency"
    @focus_area_details = "I am the focus details"
    @focus_area_info = "cc"
    @focus_area_text = "What's this?"
    @parent_tip = "Parent Tips. Suggestions for you:"
    #@parent_tip_list = "need to discuss how this works - I think that haml has list iteration"
    @child_activity_info = "Activities. Suggestions for you to do with #{student_name_obj['firstName']}:"
    @child_activity_list = "another list"
  end

  def teacher
    if session[:token].nil?
      session[:token] = get_access_token(params['code'])
    end
    teacher_json = SlcResource.fetch_teacher(nil, session[:token])["name"]
    student_json = SlcResource.fetch_students(session[:token])[0]
    teacher_comment_json = SlcResource.fetch_parent_comment(session[:token], nil)
    @teacher_last_name = teacher_json["lastSurname"]
    @teacher_full_name = "Grade 1"

    student_json = SlcResource.fetch_students(session[:token])[0]
    student_name_obj = student_json["name"]
    @student_name = "#{student_name_obj['firstName']} #{student_name_obj['lastSurname']}"
    @parent_comment = "#{teacher_comment_json['message']}"
    @title = "Reading"
    @reading_level = "G"
    @description = "Area of focus:"
    @focus_area = "Fluency"
    @focus_area_details = "I am the focus details"
    @focus_area_info = "cc"
    @focus_area_text = "What's this?"
    @parent_tip = "Parent Tips."
    #@parent_tip_list = "need to discuss how this works - I think that haml has list iteration"
    @child_activity_info = "Activities."
    @child_activity_list = "another list"
  end

  def secure
    if session[:token].nil?
      redirect_to :root
    end

    json = SlcResource.fetch_students(session[:token])

    @token = session[:token]

    build_json_display(json)
  end

  def assessments
    if session[:token].nil?
      redirect_to :root
    end

    student_id = nil

    json = SlcResource.fetch_student_assessments(student_id, session[:token])

    @token = session[:token]

    build_json_display(json)
  end

  def video
    #:category => @category, :level => @level, :player_id => @player_id, :media_id => @video.media_id

    @cms_content_id = '6891'
    @category = ''
    @level = 'level'
    @player_id = 'player_id'
    @media_id = '?'
  end



  def browse
    if session[:token].nil?
      redirect_to :root
    end

    params[:path] ||= '/staff/4069feb780f3a69b7d39cfea94f5728600152633_id/custom'
    #params[:path] ||= '/home'


    @token = session[:token]


    json = SlcResource.fetch_resource('/staff/4069feb780f3a69b7d39cfea94f5728600152633_id', session[:token])

    build_json_display(json)
  end

  def send_message_to_teacher
    message = params[:message]
    SlcResource.send_message_to_teacher(session[:token], message, nil)
    render json: {success:true}
  end

  def some_students
    params[:path] = SlcResource.STUDENTS_URI
    browse
  end

  private

  def build_json_display(json)
    if !json.is_a? Array
      json = [json]
    end

    @display_objects = []

    json.each do |item|
      saved_links = item['links'] ||= []
      item['links'] = nil
      display_object = {json:JSON.pretty_generate(item), links: saved_links}
      @display_objects << display_object

      saved_links.each do |l|
        puts l['href']
      end
    end

    @json = json
  end

end
