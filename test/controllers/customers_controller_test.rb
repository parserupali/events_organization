# frozen_string_literal: true

require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end

  test 'should get index' do
    get customers_url, as: :json
    assert_response :success
  end

  test 'should create customer' do
    assert_difference('Customer.count') do
      post customers_url, params: { customer: { phone_number: @customer.phone_number, user_id: @customer.user_id } },
                          as: :json
    end

    assert_response :created
  end

  test 'should show customer' do
    get customer_url(@customer), as: :json
    assert_response :success
  end

  test 'should update customer' do
    patch customer_url(@customer),
          params: { customer: { phone_number: @customer.phone_number, user_id: @customer.user_id } }, as: :json
    assert_response :success
  end

  test 'should destroy customer' do
    assert_difference('Customer.count', -1) do
      delete customer_url(@customer), as: :json
    end

    assert_response :no_content
  end
end
