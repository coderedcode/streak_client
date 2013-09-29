module StreakClient
  
  class Box

    attr_accessor :name, :notes, :stageKey, :fields, 
      :followerKeys, :boxKey

    def initialize(attributes)
      attributes.each do |attr_name, attr_value|
        if self.respond_to?(attr_name)
          self.send("#{attr_name}=", attr_value) 
        end
      end
    end

    def self.api_url(pipeline_key)
      StreakClient.api_url + "/pipelines/#{pipeline_key}/boxes"
    end

    def self.instance_api_url(box_key)
      StreakClient.api_url + "/boxes/#{box_key}"
    end

    def self.create(pipelineKey, attributes)
      response = RestClient.put(self.api_url(pipelineKey), attributes)
      self.new(MultiJson.load(response))
    end

    def self.find(box_key)
      self.new(MultiJson.load(RestClient.get(self.instance_api_url(box_key))))
    end

    def self.delete(box_key)
      RestClient.delete(self.instance_api_url(box_key))
    end

    def self.all
      response = MultiJson.load(RestClient.get(self.instance_api_url(nil)))
      response.map {|box_attributes| self.new(box_attributes) }
    end
  
    def newsfeed
      response = MultiJson.load(
        RestClient.get(Box.instance_api_url(boxKey) + "/newsfeed"))
      Newsfeed.new(events: response)
    end

    def threads
      response = MultiJson.load(
        RestClient.get(Box.instance_api_url(boxKey) + "/threads"))
      response.map {|thread_attributes| Thread.new(thread_attributes) }
    end

    def save!
      RestClient.post(Box.instance_api_url(boxKey), 
        {name: name, notes: notes, stageKey: stageKey}.to_json, content_type: :json)
    end

    def add_comment(message)
      response = MultiJson.load(
        RestClient.put(Box.instance_api_url(boxKey) + "/comments", "message=#{message}"))
    end

  end

end
