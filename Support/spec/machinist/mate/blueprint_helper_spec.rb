require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/../../../lib/machinist/mate/blueprint_helper'

module Machinist
  module Mate
    describe BlueprintHelper do
      before(:each) do
        @current_dir = File.dirname(__FILE__) + "/../../../fixtures/some_rails_app/spec/"
        @helper = BlueprintHelper.new(@current_dir)
      end
      describe "#generate_blueprint" do
        describe "for parent class BlogAuthor" do
          before(:each) do
            @stdout = StringIO.new
            @blueprint = @helper.generate_blueprint('BlogAuthor', @stdout)
            @stdout.rewind
            @stdout = @stdout.read
          end

          it "should render a blueprint" do
            @stdout.should == <<-EOS.gsub(/^            /, '')
            BlogAuthor.blueprint do
              name
              blog_post { BlogPost.make }
              blog_posts { [ BlogPost.make ] }
              blog_comments { [ BlogComment.make ] }
            end

            EOS
          end
        end

        describe "for middle class BlogPost" do
          before(:each) do
            @stdout = StringIO.new
            @blueprint = @helper.generate_blueprint('BlogPost', @stdout)
            @stdout.rewind
            @stdout = @stdout.read
          end

          it "should render a blueprint" do
            @stdout.should == <<-EOS.gsub(/^            /, '')
            BlogPost.blueprint do
              title
              body
              author { BlogAuthor.make }
              comments { [ BlogComment.make ] }
              tags { [ Tag.make ] }
            end

            EOS
          end
        end

        describe "for child class BlogComment" do
          before(:each) do
            @stdout = StringIO.new
            @blueprint = @helper.generate_blueprint('BlogComment', @stdout)
            @stdout.rewind
            @stdout = @stdout.read
          end

          it "should render a blueprint" do
            @stdout.should == <<-EOS.gsub(/^            /, '')
            BlogComment.blueprint do
              comment
              blog_post { BlogPost.make }
            end

            EOS
          end
        end
        
        describe "for child class Tag" do
          before(:each) do
            @stdout = StringIO.new
            @blueprint = @helper.generate_blueprint('Tag', @stdout)
            @stdout.rewind
            @stdout = @stdout.read
          end

          it "should render a blueprint" do
            @stdout.should == <<-EOS.gsub(/^            /, '')
            Tag.blueprint do
              name
            end

            EOS
          end
        end
        
        describe "for unknown class FooBar" do
          before(:each) do
            @stdout = StringIO.new
            @blueprint = @helper.generate_blueprint('FooBar', @stdout)
            @stdout.rewind
            @stdout = @stdout.read
          end

          it "should render a blueprint" do
            @stdout.should == <<-EOS.gsub(/^            /, '')
            FooBar.blueprint do
              # no model class FooBar found
            end

            EOS
          end
        end
        
        describe "#find_project_dir" do
          it "should find config/boot.rb file" do
            expected = File.expand_path(File.dirname(__FILE__) + '/../../../fixtures/some_rails_app')
            expected.should == @helper.find_project_dir(@current_dir)
          end
        end
      end
    end
  end
end
