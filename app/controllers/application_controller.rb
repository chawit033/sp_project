class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Basic
    include ActionController::Cookies

    # skip_before_action :verify_authenticity_token
    before_action :authenticate
    respond_to :json
    
    def current_user 
        @current_user
    end

    private

    def authenticate
        if credential.present?
            return authen_by_id_and_password 
        else seession_cookie.present? 
            return authen_by_session_cookie
        end
        render json: { "error": "not authenticated" }, status: 401
        warden.custom_failure! if performed?
    end


    def authen_by_id_and_password 
        id, password = user_name_and_password(request)
        user = User.find_by(user_id:(id))
         if user.present? && user.valid_password?(password)
            session[:user_id] = user.id 
            return true
        else
            teacher = Instructor.find_by(teacher_id:(id))
            if teacher.present? && teacher.valid_password?(password)
                session[:user_id] = teacher.id 
                return true
            end
        end
    end

    def authen_by_session_cookie 
        user = User.find seession_cookie["user_id"]
        if user.present? 
            @current_user = user 
            return true
        else
            teacher = Instructor.find session["user_id"]
            if teacher.present? 
                @current_user = teacher 
                return true  
            end
        end
    end

    def credential
        request.headers["Authorization"]
    end

    def session_cookie 
        cookies.encrypted["_project_session"]
    end

end

