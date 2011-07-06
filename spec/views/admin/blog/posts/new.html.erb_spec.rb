require 'spec_helper'

describe 'admin/blog/posts/new.html.erb' do
  let (:post) do
    stub_model(BlogPost,
               :title => "Blog",
               :published_at => Time.now,
               :draft => false
               )
  end
  
  before do
    assign(:blog_post, post)
    view.should_receive(:blog_post_teaser).and_return("Lorem ipsum")
  end
  
  it "should let users mark the blog post as a bookmark link" do
    render
    rendered.should contain("is a bookmark link?") # in the more options field
#   rendered.should contain checkbox for is_link boolean
#   rendered.should contain text field for link_url string
  end
end