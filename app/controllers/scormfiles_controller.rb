class ScormfilesController < ApplicationController
  include SocialStream::Controllers::Objects

  def show
    respond_to do |format|
      format.zip {
        resource.increment_download_count
        return send_file resource.getZipPath(), :type=>"application/zip"
      }
      format.scorm {
        resource.increment_download_count
        return send_file resource.getZipPath(), :type=>"application/zip"
      }
      format.json {
        render :json => resource.as_json
      }
      format.full{
        @scormfile = resource
      }
      format.all {
        super
      }
    end
  end

  def update
    super
  end

  def destroy
    destroy! do |format|
      format.html {
        redirect_to user_path(current_user)
       }
    end
  end


  private

  def allowed_params
    [:lourl,  :lopath, :zipurl, :zippath, :width, :height, :language, :age_min, :age_max]
  end
  
end
