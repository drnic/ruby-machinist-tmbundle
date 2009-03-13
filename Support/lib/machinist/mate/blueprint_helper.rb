module Machinist
  module Mate
    class BlueprintHelper
      attr_reader :current_class
      def initialize(current_word)
        @current_class = current_word
      end

      def generate_blueprint(stdout)
        stdout.puts <<-EOS.gsub(/^        /, '')
        #{current_class}.blueprint do
          $0
        end
        
        EOS
      end
    end
  end
end
