class BlogAuthor < ActiveRecord::Base
  has_many :blog_posts
  has_many :blog_comments, :through => :blog_posts, :source => :comments
  has_one :blog_post
end
