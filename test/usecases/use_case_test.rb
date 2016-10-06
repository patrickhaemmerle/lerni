class UseCaseTest < ActiveSupport::TestCase
    
    class MyUseCase
        include UseCase
    end
    
    class MyImplementedUseCase
       include UseCase
       
       def perform
           return "foobar"
       end
    end
    
    test "perform raises not implemented" do
        assert_raises NotImplementedError do
            MyUseCase.perform
        end
    end
    
    test "UseCase returns itself" do
        assert_instance_of MyImplementedUseCase, MyImplementedUseCase.perform
    end
    
end