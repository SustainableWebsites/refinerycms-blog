class AddLinkBookleanAndUrlToPost < ActiveRecord::Migration
  def self.up
    add_column :blog_posts, :url, :string
    add_column :blog_posts, :is_link, :boolean
  end

  def self.down
    remove_column :blog_posts, :url
    remove_column :blog_posts, :is_link
  end
end