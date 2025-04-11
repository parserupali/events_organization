require "test_helper"

class EventOrganizersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_organizer = event_organizers(:one)
  end

  test "should get index" do
    get event_organizers_url, as: :json
    assert_response :success
  end

  test "should create event_organizer" do
    assert_difference("EventOrganizer.count") do
      post event_organizers_url, params: { event_organizer: { company_name: @event_organizer.company_name, phone_number: @event_organizer.phone_number, user_id: @event_organizer.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show event_organizer" do
    get event_organizer_url(@event_organizer), as: :json
    assert_response :success
  end

  test "should update event_organizer" do
    patch event_organizer_url(@event_organizer), params: { event_organizer: { company_name: @event_organizer.company_name, phone_number: @event_organizer.phone_number, user_id: @event_organizer.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy event_organizer" do
    assert_difference("EventOrganizer.count", -1) do
      delete event_organizer_url(@event_organizer), as: :json
    end

    assert_response :no_content
  end
end
