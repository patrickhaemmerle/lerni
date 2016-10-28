class Box::AddCardToBoxActionTest < ActiveSupport::TestCase
    
    setup do
        @default_params = {front: "question", back: "answer", box_id: boxes(:one).id, user_id: users(:one).id}
    end
    
    test "successful call" do
        assert_difference("Card.count") do
            result = Box::AddCardToBoxAction.perform @default_params
            assert result.success?
        end
    end
    
    test "card id references the created card" do
        result = Box::AddCardToBoxAction.perform @default_params
        card = Card.find result.card_id
        assert_equal card.front, @default_params[:front]
        assert_equal card.back, @default_params[:back]
        assert_equal card.box.id, @default_params[:box_id]
    end
    
    test "user does not exist" do
        @default_params["user_id"] = 123999
        result = nil
        assert_no_difference("Card.count") do
            result = Box::AddCardToBoxAction.perform @default_params
        end
        assert_not result.success?
        assert result.errors.details["user_id"]
        assert_equal 1, result.errors.count
    end
    
    test "box does not exist" do
        @default_params["box_id"] = 123999
        result = nil
        assert_no_difference("Card.count") do
            result = Box::AddCardToBoxAction.perform @default_params
        end
        assert_not result.success?
        assert result.errors.details["box_id"]
        assert_equal 1, result.errors.count
    end
    
    test "box does not belong to user" do
        @default_params["box_id"] = boxes(:three).id
        result = nil
        assert_no_difference("Card.count") do
            result = Box::AddCardToBoxAction.perform @default_params
        end
        assert_not result.success?
        assert result.errors.details["user_id"]
        assert_equal 1, result.errors.count
    end
    
    test "user and box do not exist" do
        @default_params["box_id"] = 123999
        @default_params["user_id"] = 123999
        result = nil
        assert_no_difference("Card.count") do
            result = Box::AddCardToBoxAction.perform @default_params
        end
        assert_not result.success?
        assert result.errors.details["box_id"]
        assert result.errors.details["user_id"]
        assert_equal 2, result.errors.count
    end
    
    test "front may not be nil" do
        @default_params["front"] = nil
        result = nil
        assert_no_difference("Card.count") do
            result = Box::AddCardToBoxAction.perform @default_params
        end
        assert_not result.success?
        assert result.errors.details["front"]
        assert_equal 1, result.errors.count
    end
    
    test "front may not be blank" do
        @default_params["front"] = "  "
        result = nil
        assert_no_difference("Card.count") do
            result = Box::AddCardToBoxAction.perform @default_params
        end
        assert_not result.success?
        assert result.errors.details["front"]
        assert_equal 1, result.errors.count
    end
    
    test "back may not be nil" do
        @default_params["back"] = nil
        result = nil
        assert_no_difference("Card.count") do
            result = Box::AddCardToBoxAction.perform @default_params
        end
        assert_not result.success?
        assert result.errors.details["back"]
        assert_equal 1, result.errors.count
    end
    
    test "back may not be blank" do
        @default_params["back"] = "  "
        result = nil
        assert_no_difference("Card.count") do
            result = Box::AddCardToBoxAction.perform @default_params
        end
        assert_not result.success?
        assert result.errors.details["back"]
        assert_equal 1, result.errors.count
    end
    
end