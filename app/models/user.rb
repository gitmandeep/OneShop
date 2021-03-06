class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :addresses 
  has_one  :cart, dependent: :destroy
  has_one  :customer, dependent: :destroy
  has_many :user_charges
  has_many :orders
  has_many :user_cards, dependent: :destroy
  after_create :send_msg

  accepts_nested_attributes_for :addresses, allow_destroy: true

  # validate :password_complexity
  validates :first_name, :last_name, :dob, :email, :mobile, presence: true
  
  # after_create :assign_cart
  #after_create :send_msg, :send_mail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2] 

  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      #user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      first_name = data['name'].split(" ")[0]
      last_name = data['name'].split(" ")[1] 
      user = User.new(first_name: first_name,
        last_name: last_name,
        email: data['email'],
        uid: access_token['uid'],
        provider: access_token['provider'],
        password: Devise.friendly_token[0,20]
      )
      user.save(validate: false)
    end
    user
  end

  private

  def assign_cart
    create_cart
  end

  def send_msg
    client = Twilio::REST::Client.new('ACb2ad07724169ab5a936792cab72db14c', 'c36f5a2288b4ff5bacce781ed0519d2f')
    $client.api.account.messages.create(
    from: '+18476968891',
    to: '+917987392544',
    body: 'Hey there! You are Successfully Login in OneShop.'
    )
  end

  def send_mail
    UserMailer.welcome_email(self).deliver_now
  end

  
  
  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,20}$/

    errors.add :password, 'Complexity requirement not met. Length should be 6-20 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

end
