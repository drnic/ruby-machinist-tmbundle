class BlogComment < ActiveRecord::Base
  belongs_to :blog_post
end
