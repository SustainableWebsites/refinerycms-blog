module WordPress
  class Tag
    attr_accessor :name

    def initialize(text)
      @name = text
    end

    def ==(other)
      name == other.name
    end
    
  end
end
