# TextMate bundle for Machinist

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
