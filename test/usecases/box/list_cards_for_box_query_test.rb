class Box::ListCardsForBoxQueryTest < ActiveSupport::TestCase
    
    setup do
        @default_params = {box_id: boxes(:one).id, user_id: users(:one).id}
    end
    
    test "successful call" do
        result = Box::ListCardsForBoxQuery.perform @default_params
        
        assert result.success?
        assert_equal 2, result.cards.count
        result.cards.each do |card|
            assert card.is_a? Card
            assert_equal @default_params[:box_id], card.box.id
            assert_equal @default_params[:user_id], card.box.user.id  
        end
    end
    
    test "successful call with empty box" do
        @default_params = {box_id: boxes(:three).id, user_id: users(:two).id}
        result = Box::ListCardsForBoxQuery.perform @default_params
        
        assert result.success?
        assert_equal 0, result.cards.count
    end
    
    test "error if box does not belong to user" do
        @default_params[:box_id] = boxes(:three).id
        result = Box::ListCardsForBoxQuery.perform @default_params
        
        assert_not result.success?
        assert result.errors.details[:box_id] 
        assert_nil result.cards
    end
    
    test "error if box does not exist" do
        @default_params[:box_id] = 99888777
        result = Box::ListCardsForBoxQuery.perform @default_params
        
        assert_not result.success?
        assert result.errors.details[:box_id]
        assert_nil result.cards
    end
    
    test "error if box is not given" do
        @default_params.delete(:box_id)
        result = Box::ListCardsForBoxQuery.perform @default_params
        
        assert_not result.success?
        assert result.errors.details[:box_id]
        assert_nil result.cards
    end
    
    test "error if user does not exist" do
        @default_params[:user_id] = 99888777
        result = Box::ListCardsForBoxQuery.perform @default_params
        
        assert_not result.success?
        assert result.errors.details[:user_id]
        assert_nil result.cards
    end
    
    test "error if user is not given" do
        @default_params.delete(:user_id)
        result = Box::ListCardsForBoxQuery.perform @default_params
        
        assert_not result.success?
        assert result.errors.details[:user_id]
        assert_nil result.cards
    end
    
end