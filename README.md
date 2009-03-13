# TextMate bundle for Machinist

## Features

Within blueprints.rb file:

### Cmd+B - convert current word or clipboard into automatic blueprint

Consider a BlogPost that has many BlogComments in a blog app. If you go to your blueprints.rb file, type "BlogPost" and press "Cmd+B" the bundle will load up the BlogPost class, inspect it, and generate the following blueprint:

    BlogPost.blueprint do
      title
      body
    end

Classes with foreign keys will generate a blueprint field too (see `blog_post` below):

    BlogComment.blueprint do
      blog_post
      comment
    end


## Installation

To install with Git:

    mkdir -p ~/Library/Application\ Support/TextMate/Bundles
    cd ~/Library/Application\ Support/TextMate/Bundles
    git clone git://github.com/drnic/ruby-machinist-tmbundle.git "Ruby on Rails.tmbundle"
    osascript -e 'tell app "TextMate" to reload bundles'


To install without Git:

    mkdir -p ~/Library/Application\ Support/TextMate/Bundles
    cd ~/Library/Application\ Support/TextMate/Bundles
    wget http://github.com/drnic/ruby-machinist-tmbundle/tarball/master
    tar zxf drnic-ruby-machinist-tmbundle*.tar.gz
    rm drnic-ruby-machinist-tmbundle*.tar.gz
    mv drnic-ruby-machinist-tmbundle* "Ruby on Rails.tmbundle"
    osascript -e 'tell app "TextMate" to reload bundles'
