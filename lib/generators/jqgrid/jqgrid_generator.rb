class JqgridGenerator < Rails::Generators::NamedBase

  argument :columns, :type => :array, :default => [], :banner => "column column"
  #     attr_reader :model_name
  #     attr_reader :columns  
  source_root File.expand_path('../templates', __FILE__)
  #     def initialize(runtime_args, *runtime_options)
  #       super
  #       puts runtime_args.inspect
  #       @model_name = runtime_args.delete_at(0)
  #       @columns = runtime_args
  #       puts @columns#.collect { |x| ":" + x + " => params[:" + x + "], " }.to_s.chomp!(', ') 
  #     end
  # argument :attributes, :type => :array, :default => [], :banner => "model column column"
  # def manifest
  #   record do |m|
  #       m.route_resources plural
  #       m.directory("app/views/#{plural}")
  #       m.template('controller.rb', "app/controllers/#{plural}_controller.rb")
  #       m.template('index.html.erb', "app/views/#{plural}/index.html.erb")
  #   end
  # end

  def create_controller_files
    template 'controller.rb', File.join('app/controllers', class_path, "#{plural_name}_controller.rb")  
    #   puts plural_name
    #   puts class_name.pluralize
    #   puts camel
    #   puts file_name
    puts columns.collect { |x| ":" + x + " => params[:" + x + "],"}.join.chomp(",")
  
  end

  # def main
  #       template('controller.rb', "app/controllers/#{plural}_controller.rb")
  #       template('index.html.erb', "app/views/#{plural}/index.html.erb")
  #     end
  # def plural
  #     model_name.pluralize
  #   end
  # 
  def model_name
    file_name
  end
  def camel
    file_name.camelcase
  end
  # 
  def klass
      @klass ||= Kernel.const_get("#{camel}")
    end

end
