require "fileutils"

module Machinist
  module Mate
    class BlueprintHelper
      attr_reader :current_class, :current_class_name
      def initialize(current_dir)
        @current_dir = current_dir
      end

      def generate_blueprint(current_word, stdout = $stdout)
        load(File.join(project_root, "config", "environment.rb"))
        methods_str = ""
        begin
          @current_class_name = current_word.classify
          @current_class = @current_class_name.constantize
          methods = @current_class.new.attributes.keys
          methods -= %w[created_at updated_at]
          methods.reject! { |method| method =~ /(.*)_id/ }
          methods.sort!

          methods_str = methods.map { |m| "  #{m}\n" }.join
          
          singular_reflections.each do |method, class_name|
            methods_str << "  #{method} { #{class_name}.make }\n"
          end
          has_many_reflections.each do |method, class_name|
            methods_str << "  #{method} { [ #{class_name}.make ] }\n"
          end
        rescue NameError => e
          methods_str = "# no model class #{current_class_name} found"
        end
        stdout.puts <<-EOS.gsub(/^        /, '')
        #{current_class_name}.blueprint do
          #{methods_str.strip}
        end
        
        EOS
      end
      
      def generate_blueprint_from_db(current_word, stdout = $stdout)
        load(File.join(project_root, "config", "environment.rb"))
        methods_str = ""
        begin
          @current_class_name = current_word.classify
          @current_class = @current_class_name.constantize
          methods = @current_class.new.attributes.keys
          methods -= %w[created_at updated_at]
          methods.reject! { |method| method =~ /(.*)_id/ }
          methods.sort!
          example_model = @current_class.first
          
          methods_str = methods.map do |m|
            sample = example_model.send(m.to_sym)
            "  #{m} { #{sample.inspect } }\n"
          end.join
          
          # singular_reflections.each do |method, class_name|
          #   methods_str << "  #{method} { #{class_name}.make }\n"
          # end
          # has_many_reflections.each do |method, class_name|
          #   methods_str << "  #{method} { [ #{class_name}.make ] }\n"
          # end
        rescue NameError
          methods_str = "# no model class #{current_class_name} found"
        end
        stdout.puts <<-EOS.gsub(/^        /, '')
        #{current_class_name}.blueprint do
          #{methods_str.strip}
        end
        
        EOS
      end

      def find_project_dir(current_dir)
        return nil unless File.exists?(current_dir)
        current_dir = File.expand_path(current_dir)
        FileUtils.chdir(current_dir) do
          parent_dir = File.expand_path("..")
          return nil if parent_dir == current_dir
          boot_file = File.join(current_dir, "config", "boot.rb")
          return File.exists?(boot_file) ? current_dir : find_project_dir(parent_dir)
        end
      end

      protected
      def project_root
        @project_root ||= find_project_dir(@current_dir)
      end
      
      # Returns list of [belongs_to_method, class_name]
      def singular_reflections
        @current_class.reflections.inject([]) do |mem, pair|
          name, reflection = pair
          next mem unless [:belongs_to, :has_one].include?(reflection.macro)
          mem << [name, reflection.class_name]
          mem
        end.sort { |a, b| a.first.to_s <=> b.first.to_s }
      end

      # Returns list of [has_many_method, class_name]
      def has_many_reflections
        @current_class.reflections.inject([]) do |mem, pair|
          name, reflection = pair
          next mem unless [:has_many, :has_and_belongs_to_many].include?(reflection.macro)
          mem << [name, reflection.class_name]
          mem
        end.sort { |a, b| a.first.to_s <=> b.first.to_s }
      end
    end
  end
end
