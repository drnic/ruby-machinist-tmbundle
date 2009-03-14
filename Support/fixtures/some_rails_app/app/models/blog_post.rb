class BlogPost < ActiveRecord::Base
  belongs_to :author, :class_name => "BlogAuthor", :foreign_key => "blog_author_id"
  has_many :comments, :class_name => "BlogComment", :foreign_key => "blog_post_id"
  has_and_belongs_to_many :tags
end
