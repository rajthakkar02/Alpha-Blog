require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "Travel")
    @category1 = Category.create(name: "Sports")
  end

  test "should show categories listing" do
    get "/categories"
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category1), text: @category1.name
  end
end
