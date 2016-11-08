class Box::ListCardsForBoxQueryTest < ActiveSupport::TestCase
    
    setup do
        @default_params = {box_id: boxes(:one).id, user_id: users(:one).id}
    end
    
    test "successful call" do
        result = Box::ListCardsForBoxQuery.perform @default_params
        
        assert result.success?
        assert_equal 2, result.cards.count
        result.cards.each do |card|
            reference = Card.find card[:id]
            assert card.is_a? Hash
            assert_equal @default_params[:box_id], card[:box_id]
            assert_equal reference.box_id, card[:box_id]
            assert_equal reference.front, card[:front]
            assert_equal reference.back, card[:back]
        end
    end
    
    test "successful call also loads the box" do
        result = Box::ListCardsForBoxQuery.perform @default_params
        
        assert result.success?
        assert result.box.is_a? Hash
        assert_equal boxes(:one).id, result.box[:id]
        assert_equal boxes(:one).user_id, result.box[:user_id] 
        assert_equal boxes(:one).name, result.box[:name]
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