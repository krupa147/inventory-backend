class JsonWebToken
  class << self
    def encode(payload)
      payload = { email: payload, time: Time.now.utc }
      JWT.encode(payload, Rails.application.credentials.secret_key_base)
    end

    def decode(token)
      payload_hash = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
      payload_hash = HashWithIndifferentAccess.new payload_hash
      payload_hash[:email]
    rescue
      nil
    end
  end
end
