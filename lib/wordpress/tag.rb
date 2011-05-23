module WordPress
  class Tag
    attr_accessor :name

    def initialize(text)
      @name = text
    end

    def ==(other)
      name == other.name
    end

    def to_refinery
      ActsAsTaggableOn::Tag.new(:name => name)
    end
    
  end
end
