require File.expand_path("../user", __FILE__)

SALT_STRING = '1234567890abcdef'

describe User do
  before :each do
    @user = User.new()
  end

  it "should have first name" do
    @user.should be_respond_to(:first_name)
    #User.new.public_methods.include?(:first_name).should be_true
    #User.new.public_methods.should include(:first_name)
  end

  it "should have last name" do
    @user.should be_respond_to(:last_name)
  end

  it "should save value first name" do
    @user.first_name = "random first name"
    @user.first_name.should == "random first name"
  end

  it "should save value last name" do
    @user.last_name = "123456"
    @user.last_name.should == "123456"
  end

  it "should not accept a nil value for first_name" do
    expect { @user.first_name = nil }.to raise_error()
  end

  it "should not accept empty value for first_name" do
    expect { @user.first_name = "" }.to raise_error()
  end

  it "should not accept nil value for last_name" do
    expect { @user.last_name = nil }.to raise_error()
  end

  it "should not accept empty value for last_name" do
    expect { @user.last_name = "" }.to raise_error()
  end

  it "should have age" do
    @user.should be_respond_to(:age)
  end

  it "should save age value" do
    @user.age = 25
    @user.age.should == 25
  end

  it "should age be a Fixnum" do
    [34.5, "asd", 'd', :wsdc, nil].each do |i|
      expect { @user.age = i }.to raise_error(ArgumentError, "age must be Fixnum")
    end
  end

  it "should have age not less than 18" do
    (-17..17).each do |i|
      expect { @user.age = i }.to raise_error(ArgumentError, "age must be not less than 18 and not more than 90")
    end
  end

  it "should have age not more than 90" do
    (91..128).each do |i|
      expect { @user.age = i }.to raise_error(ArgumentError, "age must be not less than 18 and not more than 90")
    end
  end

  it "should be between 18 and 90" do
    (18..90).each do |i|
      expect { @user.age = i }.to_not raise_error()
    end
  end


  describe "login" do
    it "should have login" do
      @user.should be_respond_to(:login)
    end

    it "should not accept a nil value for login" do
      expect { @user.login = nil }.to raise_error()
    end

    it "should not accept empty value for login" do
      expect { @user.login = "" }.to raise_error()
    end

    it "should save value login" do
      @user.login = "random login"
      @user.login.should == "random login"
    end

    it "should have login at least 4 characters" do
      expect { @user.login = "abc" }.to raise_error(ArgumentError, "login shorter than 4 characters")
    end
  end

  describe "password" do
    it "should be" do
      @user.should be_respond_to(:password)
    end

    it "should not accept nil value" do
      expect { @user.password = nil }.to raise_error()
    end

    it "should not accept empty value" do
      expect { @user.password = "" }.to raise_error()
    end

    it "should be hashed" do
      @user.password = "123456"
      @user.password.should == Digest::MD5.hexdigest("123456" + SALT_STRING)
    end

    it "should have password at least 6 characters" do
      expect { @user.password = "abcde" }.to raise_error(ArgumentError, "password shorter than 6 characters")
    end
  end

# тесты для конструктора
  it "should create object with attributes" do
     @user = User.new( first_name: "first name",
                       last_name: 'last name',
                       age: 35,
                       login: 'login',
                       password: 'password')

    #@user = User.new('first name', 'last name', 35, 'login', 'password')

    @user.first_name.should == 'first name'
    @user.last_name.should == 'last name'
    @user.age.should == 35
    @user.login.should == "login"
    @user.password.should == "password"
  end

  describe "#authenticate" do
    it "should return TRUE if credentials is right" do
      @user.login = "login"
      @user.password = "password"
      @user.authenticate("login", "password").should be_true
    end

    it "should return FALSE if credentials is wrong" do
      @user.login = "login"
      @user.password = "password"
      @user.authenticate("asd1234", "asdewq1234").should be_false
    end
  end


end


#*      Создать конструктор для класса User
#      принимает
#      User.new()

# first_name
# last_name
# age
# login
# password


#  логин  и пароль
#  метод autenticate - передает логин и пароль, если совпадают с теми что в экземпляре - true
#  и false если иначе
#  login и пароль не могут быть пустыми и не могут быть nil
# логин не менее 4-х  символов  
#~ не менее 6 символов  - пароль
#  

#*   Есть в Ruby md5, хешировать и хранить при его помощи пароль  +  добавлять к нему постоянную строчку

