class AddBlogAuthorToBlogPost < ActiveRecord::Migration
  def self.up
    add_column :blog_posts, :blog_author_id, :integer
  end

  def self.down
    remove_column :blog_posts, :blog_author_id
  end
end
