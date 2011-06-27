require 'spec_helper'

describe "blog/shared/_post.html.erb" do
  it "should let users mark the blog post as a bookmark link" do
    assign(:post, mock_model("Post"))
    render
    rendered.should contain("is a bookmark link?") # in the more options field
#   rendered.should contain checkbox for is_link boolean
#   rendered.should contain text field for link_url string
  end
end