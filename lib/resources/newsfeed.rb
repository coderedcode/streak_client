module StreakClient
  
  class Newsfeed

    attr_accessor :events

    def initialize(attributes)
      attributes.each do |attr_name, attr_value|
        if self.respond_to?(attr_name)
          self.send("#{attr_name}=", attr_value) 
	end
      end
    end

  end

end
