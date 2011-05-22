module WordPress
  class Page
    attr_reader :node
    
    def initialize(node)
      @node = node
    end

    def inspect
      "WordPress::Page(#{post_id}): #{title}"     
    end

    def title
      node.xpath("title").text
    end

    def content
      node.xpath("content:encoded").text
    end

    def creator
      node.xpath("dc:creator").text
    end

    def post_date
      DateTime.parse node.xpath("wp:post_date").text
    end

    def post_id
      node.xpath("wp:post_id").text.to_i
    end

    def parent_id
      node.xpath("wp:post_parent").text.to_i
    end

    def status
      node.xpath("wp:status").text
    end

    def ==(other)
      post_id == other.post_id
    end
  end
end
