class PagesController < ApplicationController
  def index
    @users = User.all
    markers_arr = []
    @json = Location.all.to_gmaps4rails do |location, marker|
      @note=location.users
      @string=""
      @note.each do |note|
        @string="#{@string} #{note.last_name} #{note.first_name} \n"
      end

      marker.title   @string
      marker.json({ :id => @note, :foo => "bar" })
    end
  end

  def loadusers
    grupa=params["grupa"]
    promotia=params["promotia"]
    specializarea=params["specializarea"].strip
    if  (grupa=="Toate grupele"&& promotia=="Toate promotile"&&specializarea=="Toate specializarile")
     @user=User.all
    elsif (grupa=="Toate grupele"&& promotia=="Toate promotile")
      @user=User.where("specialization = ?",specializarea)
    elsif (grupa=="Toate grupele"&& specializarea=="Toate specializarile")
      @user=User.where("promotion = ?",promotia)
    elsif (promotia=="Toate promotile"&& specializarea=="Toate specializarile")
      @user=User.where("agroup = ?",grupa)
    elsif (grupa=="Toate grupele")
      @user=User.where("promotion = ? AND specialization = ?",promotia,specializarea)
    elsif (promotia=="Toate promotile")
      @user=User.where("agroup = ? AND specialization = ?",grupa,specializarea)
    elsif(specializarea=="Toate specializarile")
      @user=User.where("agroup = ? AND promotion = ?",grupa,promotia)
    elsif
     @user=User.where("agroup =? AND promotion =? AND specialization =?",grupa,promotia,specializarea)
    end
    
    respond_to do |format|
      format.json { render :json => @user }
    end
  end

  def statistici
    @job_hash = Hash.new()

    programmer_keywords = ["programmer", "developer"]
    @job_hash[:programmer] = 0
    programmer_keywords.each do |programmer_keyword|
      how_many = Experience.where("job_title ilike ?", "%#{programmer_keyword}%").count
      @job_hash[:programmer] += how_many
    end

    @job_hash[:management] = 0
    manager_keywords = ["manager", "executive"]
    manager_keywords.each do |manager_keyword|
      @job_hash[:management] += Experience.where("job_title ilike ?", "%#{manager_keyword}%").count
    end
  end
end
