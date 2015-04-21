class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_secure_password

  def self.authorize!(env)
    token = sanitize_token(env)
    token.present? ? find_by_authentication_token(token) : false
  end

  def generate_authentication_token!
    begin
      self.authentication_token = SecureRandom.hex
    end while self.class.exists?(authentication_token: authentication_token)
    self.save!
  end

  def login_json_info
    as_json(only: [:id, :name, :email, :authentication_token])
  end

  private

  def self.sanitize_token(env)
    token = env['HTTP_AUTHORIZATION']
    token.gsub!(/\A"|"\Z/, '') if token.present?
    token
  end
end
