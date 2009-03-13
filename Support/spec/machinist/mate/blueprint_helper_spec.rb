require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/../../../lib/machinist/mate/blueprint_helper'

module Machinist
  module Mate
    describe BlueprintHelper do
      before(:each) do
        @helper = BlueprintHelper.new('BlogPost')
      end
      describe "#generate_blueprint" do
        before(:each) do
          @stdout = StringIO.new
          @blueprint = @helper.generate_blueprint(@stdout)
          @stdout.flush
          @stdout = @stdout.read
        end

        it "should render a blueprint" do
          @stdout.should == <<-EOS.gsub(/^          /, '')
          BlogPost.blueprint do
            $0
          end
          
          EOS
        end
      end
    end
  end
end
