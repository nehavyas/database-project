require 'digest/sha2'

class Employee < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  after_destroy :ensure_an_admin_remains

  def ensure_an_admin_remains
    if Employee.count.zero?
      raise "Can't delete last user"
    end
  end

  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader  :password 

  validate   :password_must_be_present

  def Employee.authenticate(name, password)
    if employee = find_by_name(name)
      if employee.hashed_password == encrypt_password(password, employee.salt)
         employee
      end
    end
  end

  def Employee.encrypt_password(password, salt) 
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end

    
  def password=(password)
     @password = password

     if password.present?
       generate_salt
       self.hashed_password = self.class.encrypt_password(password, salt)

     end
  end



  private 

    def password_must_be_present
       errors.add( :password, "Missing password") unless hashed_password.present?
    end

    def generate_salt 
      self.salt = self.object_id.to_s + rand.to_s
    end  
end
