require 'test_helper'

class KeywordMappingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @keyword_mapping = keyword_mappings(:one)
  end

  test "should get index" do
    get keyword_mappings_url
    assert_response :success
  end

  test "should get new" do
    get new_keyword_mapping_url
    assert_response :success
  end

  test "should create keyword_mapping" do
    assert_difference('KeywordMapping.count') do
      post keyword_mappings_url, params: { keyword_mapping: { channel_id: @keyword_mapping.channel_id, keyword: @keyword_mapping.keyword, message: @keyword_mapping.message } }
    end

    assert_redirected_to keyword_mapping_url(KeywordMapping.last)
  end

  test "should show keyword_mapping" do
    get keyword_mapping_url(@keyword_mapping)
    assert_response :success
  end

  test "should get edit" do
    get edit_keyword_mapping_url(@keyword_mapping)
    assert_response :success
  end

  test "should update keyword_mapping" do
    patch keyword_mapping_url(@keyword_mapping), params: { keyword_mapping: { channel_id: @keyword_mapping.channel_id, keyword: @keyword_mapping.keyword, message: @keyword_mapping.message } }
    assert_redirected_to keyword_mapping_url(@keyword_mapping)
  end

  test "should destroy keyword_mapping" do
    assert_difference('KeywordMapping.count', -1) do
      delete keyword_mapping_url(@keyword_mapping)
    end

    assert_redirected_to keyword_mappings_url
  end
end
