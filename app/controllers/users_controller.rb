class UsersController < ApplicationController
  def new
    @user = User.new(:gender_id => 1)
  end

  def create
    @user = User.new(user_params)
    if @user.save

      #define_username(params[:user][:username_attributes][:name])
      #define_userlastname(params[:user][:userlastname_attributes][:lastname])
      define_gender(params[:user][:gender][:gender_id])

      #defines default values for fields had values and appeared in the edit screen
      @user.country = Country.first!
      @user.city = City.first!
      @user.relationship = Relationship.first!

      sign_in @user

      flash[:success] = "Welcome to our family! Please fill in your data below."
      redirect_to edit_user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 6)
  end

  def edit
    @user = User.find(params[:id])
  end

  #not used
  def update_name
    @user = User.find(params[:id])
    if @user.update_attribute(:name, params[:user][:name])
      #flash[:success] = "name updated"
      redirect_to @user
    else
      flash[:danger] = "not success"
      render 'edit'
    end
  end

  def update_userinfo
    @user = User.find(params[:id])
    @user.update_attributes(user_params)


    @user.relationship_id = params[:user][:relationship_id]
    @user.country = Country.find_by(:id => params[:user][:country_id])
    #@user.birthdate = params[:user][:birthdate
    @user.birthdate = Date.new(params[:user]["birthdate(1i)"].to_i,params[:user]["birthdate(2i)"].to_i,params[:user]["birthdate(3i)"].to_i)



    #define_username(params[:user][:username_attributes][:name])
    #define_userlastname(params[:user][:userlastname_attributes][:lastname])
    define_gender(params[:user][:gender_id])
    define_city(params[:user][:city_attributes][:cityname], params[:user][:country_id])


    render 'edit'

  end

  def post

  end



  private

    def user_params
      params.require(:user).permit(:name, :lastname, :gender_id, :email, :avatar, :password, :password_confirmation)
    end

    def define_username(name)
      @user.username_id = 1
      @username = Username.find_by(:name => name)
      if !@username.nil?
        @user.username = @username
      else
        @newname = Username.new(:name => name)
        @newname.save
        @user.username = @newname
      end
    end

    def define_userlastname(lastname)
      @user.userlastname_id = 1
      @userlastname = Userlastname.find_by(:lastname => lastname)
      if !@userlastname.nil?
        @user.userlastname = @userlastname
      else
        @newlastname = Userlastname.new(:lastname => lastname)
        @newlastname.save
        @user.userlastname = @newlastname
      end
    end

    def define_gender(gender_id)
      @user.gender_id = 1
      @user.update_attribute(:gender_id, gender_id)
      @user.save
    end


    def define_city(city, country_id)
      @user.city_id = 1
      @city = City.find_by(:cityname => city)
      if !@city.nil?
       @user.update_attribute(:city_id, @city.id)
      else
        @newcity = City.new(:cityname => city, :country_id => country_id)
        @newcity.save
        @user.update_attribute(:city_id, @newcity.id)
      end
    end


end

