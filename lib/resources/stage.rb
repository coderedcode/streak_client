module StreakClient
  
  class Stage

    attr_accessor :name, :key

    def initialize(attributes)
      attributes.each do |attr_name, attr_value|
        if self.respond_to?(attr_name)
          self.send("#{attr_name}=", attr_value) 
        end
      end
    end

    def self.api_url(pipeline_key)
      StreakClient.api_url + "/pipelines/#{pipeline_key}/stages"
    end
    
    def self.create(pipelineKey, attributes)
      response = RestClient.put(self.api_url(pipelineKey), attributes)
      self.new(MultiJson.load(response))
    end

    def self.delete(pipelineKey, stageKey)
      RestClient.delete("#{self.api_url(pipelineKey)}/#{stageKey}")
    end

  end

end
