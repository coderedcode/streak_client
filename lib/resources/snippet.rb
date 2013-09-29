module StreakClient
  
  class Snippet

    attr_accessor :userKey, :creationDate, :partOfPipeline, :snippetText, 
      :snippetName, :snippetType, :snippetKey, :key

    def initialize(attributes)
      attributes.each do |attr_name, attr_value|
        if self.respond_to?(attr_name)
          self.send("#{attr_name}=", attr_value)
	    end
      end
    end

    def self.api_url
      StreakClient.api_url + "/snippets"
    end
    
    def self.find(snippet_key)
      self.new(MultiJson.load(RestClient.get("#{self.api_url}/#{snippet_key}")))
    end

    def self.all
      self.new(MultiJson.load(RestClient.get("#{self.api_url}")))
    end

  end

end
