module WordPress
  class Post < Page
    def tags
      node.xpath("category[@domain='post_tag']").collect do |tag_node| 
        WordPress::Tag.new(tag_node.text)
      end
    end

    def tag_list
      tags.collect(&:name).join(',')
    end

    def categories
      node.xpath("category[@domain='category']").collect do |cat|
        WordPress::Category.new(cat.text)
      end
    end
  end
end
