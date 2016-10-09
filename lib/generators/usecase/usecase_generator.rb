class UsecaseGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  
  def generate_usecase 
    unless (name.end_with? "_action" or name.end_with? "_query")
        raise "Name must end with Action or Query"
    end
    template "usecase.rb", "app/usecases/#{name}.rb" 
    template "usecase_test.rb", "test/usecases/#{name}_test.rb" 
  end
  
end
