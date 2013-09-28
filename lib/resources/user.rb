module StreakClient
  
  class User

    attr_accessor :email, :lastSeenTimestamp, :isOauthComplete, :displayName, :key

    def initialize(attributes)
      attributes.each do |attr_name, attr_value|
        if self.respond_to?(attr_name)
          self.send("#{attr_name}=", attr_value)
	    end
      end
    end

    def self.api_url
      StreakClient.api_url + "/users"
    end
    
    def self.find(user_key)
      self.new(MultiJson.load(RestClient.get("#{self.api_url}/#{user_key}")))
    end

    def self.find_me
      self.new(MultiJson.load(RestClient.get("#{self.api_url}/me")))
    end

  end

end
