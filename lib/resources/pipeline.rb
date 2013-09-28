module StreakClient
  
  # TODO abstract out attributes so we don't list them everywhere
  # (edit/get) do this for other resources too
  # need to separate readable and writeable attributes
  class Pipeline

    ASSOCIATIONS = [:stages, :boxes]
    attr_accessor :name, :description, :orgWide, :fieldNames, 
      :fieldTypes, :stages, :pipelineKey

    def self.api_url
      StreakClient.api_url + "/pipelines"
    end

    def initialize(attributes)
      attributes.each do |attr_name, attr_value| 	
        if self.respond_to?(attr_name) && !ASSOCIATIONS.include?(attr_name)
          self.send("#{attr_name}=", attr_value) 
        end
      end
    end

    def self.create(attributes)
      response = RestClient.put(self.api_url, attributes)
      self.new(MultiJson.load(response))
    end

    def self.find(pipeline_key)
      self.new(MultiJson.load(RestClient.get("#{self.api_url}/#{pipeline_key}")))
    end

    def self.delete(pipeline_key)
      RestClient.delete("#{self.api_url}/#{pipeline_key}")
    end

    def self.all
      response = MultiJson.load(RestClient.get(self.api_url))
      response.map {|pipeline_attributes| self.new(pipeline_attributes) }
    end

    def newsfeed
      response = MultiJson.load(
        RestClient.get(Pipeline.api_url + "/#{pipelineKey}/newsfeed"))
      Newsfeed.new(events: response)
    end

    def boxes
      response = MultiJson.load(
	RestClient.get("#{Pipeline.api_url}/#{self.pipelineKey}/boxes"))
      response.map {|box_attributes| Box.new(box_attributes) }
    end

    def stages
      response = MultiJson.load(
	RestClient.get("#{Pipeline.api_url}/#{self.pipelineKey}/stages"))
      response.map {|stage_attributes| Stage.new(stage_attributes[1]) }
    end

    def add_stage(attributes)
      Stage.create(self.pipelineKey, attributes)
    end

    def add_box(attributes)
      Box.create(self.pipelineKey, attributes)
    end

    def save!
      RestClient.post(Pipeline.api_url + "/#{pipelineKey}", 
        {name: name, description: description}.to_json, content_type: :json)
    end

  end

end
