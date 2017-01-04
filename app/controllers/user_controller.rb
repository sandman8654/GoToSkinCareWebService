class UserController < ApplicationController
  def new
  end
  #user login process
  def login
	  user = User.find_by(email: params[:email].downcase)
    result_hash = {}
    result_hash[:success]=true
    result_hash[:message]=""

    if user && user.checkpassword(user.password, params[:password])
      # Log the user in and redirect to the user's show page.
	  #render html:"OK"

      result_hash[:user]=getUserInfo(user)

    else
      # Create an error message.
      result_hash[:success]=false
      result_hash[:message]=user.errors.full_messages
    end
    require 'json'
    render json:JSON(result_hash)
  end
  # verify user address
  #if user address is incorrect, a list of alternative address will be recommanded
  def verifyAddress
    result_hash = {}
    result_hash[:success]=true
    result_hash[:message]=""
    result_hash[:isValidAddress]=false
    alternative_address={}
    alternative_address[:address_country] =""
    alternative_address[:address_street] = ""
    alternative_address[:address_street2] = ""
    alternative_address[:address_suburb] = ""
    alternative_address[:address_state] = ""
    alternative_address[:address_postcode] = ""
    recommandedList=[]
    recommandedList.push(alternative_address)
    result_hash[:recommandations]=recommandedList
    require 'json'
    render json:JSON(result_hash)
  end
  #register user profile
  def register
    result_hash = {}
    result_hash[:success]=true
    result_hash[:message]=""
    @user = User.new(user_params(true, nil))
    if @user.save
      result_hash[:user]=getUserInfo(@user)
    else
      result_hash[:success]=false
      result_hash[:message]=@user.errors.full_messages
    end
    require 'json'
    render json:JSON(result_hash)
  end

  #update user profile
  def updateProfile
    result_hash = {}
    result_hash[:success]=true
    result_hash[:message]=""
    @user = User.find_by(email: params[:email].downcase)
    if @user.update_attributes(user_params(false,user))
      # Handle a successful update.
      result_hash[:user]=getUserInfo(@user)
    else
      # Create an error message.
      result_hash[:success]=false
      result_hash[:message]=user.errors.full_messages
    end
    require 'json'
    render json:JSON(result_hash)
  end
  #resset user password
  def resetPassword
    result_hash = {}
    result_hash[:success]=true
    result_hash[:message]=""
    @user = User.find_by(email: params[:email].downcase)
    if user
      # Log the user in and redirect to the user's show page.
      #render html:"OK"
      user.password=params[:password]
      result_hash[:message]=""
    else
      # Create an error message.
      result_hash[:success]=false
      result_hash[:message]=user.errors.full_messages
    end
    require 'json'
    render json:JSON(result_hash)
  end

  private
  #get user request params
  def user_params(isNew,user)
    userinfo={}
    userinfo[:first_name] = params[:firstname]
    userinfo[:last_name] = params[:surename]
    userinfo[:email] = params[:email]
    userinfo[:company] = params[:company]
    userinfo[:password] = params[:password]
    addressinfo={}
    addressinfo[:country_code] = params[:address_country]
    addressinfo[:street] = params[:address_street]
    addressinfo[:street_2] = params[:address_street_2]
    addressinfo[:suburb] = params[:address_suburb]
    addressinfo[:state] = params[:address_state]
    addressinfo[:postcode] = params[:address_postcode]
    if isNew
      @address = AddressList.new(addressinfo)
      if @address.save
        userinfo[:addressid] = @address.id
      end
    else
      @address = AddressList.find_by(id:user.addressid)
      if @address.update_attributes(addressinfo)
        # Handle a successful update.
        userinfo[:addressid] = @address.id
      else
        # Create an error message.
        result_hash[:success]=false
        result_hash[:message]=user.errors.full_messages
      end
    end

    return userinfo
  end
  def getUserInfo(user)
    userinfo={}
    userinfo[:userId]=user.id
    userinfo[:firstname] = user.first_name
    userinfo[:surename] = user.last_name
    userinfo[:email] = user.email
    userinfo[:company] = user.company
    address = AddressList.find_by(id:user.addressid)
    if address
      userinfo[:address_country] = address.country_code
      userinfo[:address_street] = address.street
      userinfo[:address_street_2] = address.street_2
      userinfo[:address_suburb] = address.suburb
      userinfo[:address_state] = address.state
      userinfo[:address_postcode] = address.postcode
    end
    return userinfo
  end
end
