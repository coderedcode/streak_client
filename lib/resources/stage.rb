module StreakClient
  
  class Stage

    attr_accessor :name, :key, :pipelineKey

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

    def self.instance_api_url(pipelineKey, key)
      StreakClient.api_url + "/pipelines/#{pipelineKey}/stages/#{key}"
    end
    
    def self.create(pipelineKey, attributes)
      response = RestClient.put(self.api_url(pipelineKey), attributes)
      self.new(MultiJson.load(response).merge(pipelineKey: pipelineKey))
    end

    def self.delete(pipelineKey, stageKey)
      RestClient.delete("#{self.api_url(pipelineKey)}/#{stageKey}")
    end

    def save!
      RestClient.post(Stage.instance_api_url(pipelineKey, key), 
        {name: name}.to_json, content_type: :json)
    end

  end

end
