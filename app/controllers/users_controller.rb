class UsersController < ApplicationController
 # before_filter :authenticate_user!

  # GET /users
  # GET /users.json
  def index
   if !user_signed_in?
   redirect_to root_path
   else
    @users = User.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
    end
  end
  
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

#updates all clients from database 
 def update_DB
        @users=User.all
    @users.each do |user|
      if user.token
        client = LinkedIn::Client.new("mgdh4gtnqnra", "adFWD50VxWY35Yi1")
        client.authorize_from_access(user.token,user.secret)
        Rails.logger.debug user.inspect
        Rails.logger.debug "============================================================================"
        update_profile(client,user)
        update_educations(client,user)
        update_experiences(client,user)
      end
    end
    redirect_to home_path
 end

# updates the current client
  def create_from_linkedin
    auth = request.env["omniauth.auth"]
    user = User.find_by_email(auth['info']['email'])
    if(user)

    sign_in user
    client = LinkedIn::Client.new("mgdh4gtnqnra", "adFWD50VxWY35Yi1")
    client.authorize_from_access(auth['credentials']['token'],auth['credentials']['secret'])
    user.token = auth['credentials']['token'] 
    user.secret = auth['credentials']['secret'] 

    # Updated the user information
    update_profile(client,user)
    update_educations(client,user)
    update_experiences(client,user)
    redirect_to home_path
return
end
redirect_to root_path, :alert=> "Login with LinkedIn failed!!"
     end

  def update_profile(client,user)

    profile = client.profile(:fields => ["first-name", "last-name", "date-of-birth", "email-address", "location", "public-profile-url", "picture-urls::(original)"])
    profile = profile.to_hash
    user.update_attributes(:first_name => profile['first_name'], :last_name => profile['last_name'], :email => profile['email_address'])
    if profile['picture_urls']['all']
      user.imageurl = profile['picture_urls']['all'].first
    else
      user.imageurl = nil
    end
    user.ProfileUrl = profile['public_profile_url']
    if(profile['date_of_birth'])
    user.birthdate = Date.new(profile['date_of_birth']['year'], profile['date_of_birth']['month'], profile['date_of_birth']['day'])
   end

      @locations=Location.all
    loc=nil
    if(profile['location'])
    @locations.each do |location|
      if location.name == profile['location']['name']
        loc=location
      end
     end
    end
    if !loc
    loc=Location.create(:name=>profile['location']['name'])
  end
      user.location_id=loc.id

    user.save

  end

  def update_experiences(client,user)
    positions = client.profile(:fields => [:positions]).positions.all
    user.experiences.destroy_all
      if(!positions.nil?)
        positions.each do |p|
            if (p.start_date)
              if p.is_current == "true"
              Experience.create(
	              id: p.id,
                job_title: p.title, 
                description: p.summary, 
                start_date: Date.parse("1/#{p.start_date.month ? p.start_date.month : 1}/#{p.start_date.year}"), 
                end_date: Date.parse("1/#{p.end_date.month ? p.end_date.month : 1}/#{p.end_date.year}"),  
                company: p.company.name, 
                user_id: user.id)
            else
              Experience.create(
	              id: p.id,
                job_title: p.title, 
                description: p.summary, 
                start_date: Date.parse("1/#{p.start_date.month ? p.start_date.month : 1}/#{p.start_date.year}"), 
                company: p.company.name, 
                user_id: user.id)
            end
            else 
                Experience.create(
	              id: p.id,
                job_title: p.title, 
                description: p.summary, 
                company: p.company.name, 
                user_id: user.id)
 
            end
          end
      end
  end

  def update_educations(client,user)
      educations = client.profile(:fields => [:educations]).educations.all
      user.educations.destroy_all
      if(!educations.nil?)
        educations.each do |e|
            if(e.start_date && e.end_date)
              new_educations = Education.create(
	              id: e.id,
                university: e.school_name, 
                enrollment_date: Date.parse("1/#{e.start_date.month ? p.start_date.month : 1}/#{e.start_date.year}"), 
                graduation_date: Date.parse("1/#{e.end_date.month ? p.end_date.month : 1}/#{e.end_date.year}"), 
                domain: e.degree, 
                user_id: user.id) 
             else
               new_educations = Education.create(
                 id: e.id,
                 university: e.school_name,
                 domain: e.degree,
                 user_id: user.id)
             end 
        end
      end
  end
end
