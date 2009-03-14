BlogAuthor.blueprint do
  name
  blog_post { BlogPost.make }
  blog_posts { [ BlogPost.make ] }
  blog_comments { [ BlogComment.make ] }
end

BlogPost.blueprint do
  title
  body
  author { BlogAuthor.make }
  comments { [ BlogComment.make ] }
  tags { [ Tag.make ] }
end

BlogComment.blueprint do
  comment
  blog_post { BlogPost.make }
end

Tag.blueprint do
  name
end

