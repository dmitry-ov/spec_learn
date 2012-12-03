require 'digest/md5'


class User

  attr_reader :first_name, :last_name, :age, :login, :password

	SALT_STRING = '1234567890abcdef'

  #first_name = "" , last_name = "", age =  0, login = "", password = ""

  def initialize (attrs = {})
		@first_name = attrs[:first_name]
		@last_name = attrs[:last_name]
		@age = attrs[:age]
		@login = attrs[:login]
		@password = attrs[:password]
  end

  def first_name=(value)
    raise_error("first_name not accept a nil or empty value") if value.nil? || (value == "")
    @first_name = value
  end

  def last_name=(value)
    raise_error("last_name not accept a nil or empty value") if value.nil? || (value == "")
    @last_name = value
  end

  def age=(value)
    raise_error("age must be Fixnum") unless value.is_a? Fixnum
    raise_error("age must be not less than 18 and not more than 90") if (value < 18) || (value > 90)

    @age = value
  end
	
	def login=(value)
    raise_error("login not accept a nil or empty value") if value.nil? || (value == "")
    raise_error("login shorter than 4 characters") if value.size < 4
		
		@login = value
  end


  def password=(value)
    raise_error("password not accept a nil or empty value") if  value.nil? || (value == "")
    raise_error("password shorter than 6 characters") if value.size < 6
		
		@password = Digest::MD5.hexdigest(value + SALT_STRING)
  end

  def authenticate(login, password)
    pass = Digest::MD5.hexdigest(password + SALT_STRING)
    return true if (@login == login) && (@password == pass)
    false
  end


  protected

  def raise_error(message)
    raise ArgumentError.new(message)
  end

end

