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
        rescue NameError
          methods_str = "# no model class #{current_class_name} found"
        end
        stdout.puts <<-EOS.gsub(/^        /, '')
        #{current_class_name}.blueprint do
          #{methods_str}
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
    end
  end
end
