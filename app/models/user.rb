class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :provider, :uid, :email, :name, :password, :password_confirmation, :remember_me


  def self.find_or_create_by_omniauth(auth)
    if first = where(provider: auth["provider"], uid: auth["uid"]).first
      first
    else
      create do |user|
        user.provider              = auth["provider"]
        user.uid                   = auth["uid"]
        user.email                 = "#{auth["info"]["nickname"]}@twitter.com"
        user.name                  = auth["info"]["name"]
        user.password              = (rand()*1000000000).floor.to_s(32)
        user.password_confirmation = user.password
      end
    end
  end

end
