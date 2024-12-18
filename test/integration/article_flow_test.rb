require "test_helper"

class ArticleFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "rajthakkar", email: "rajthakkar@gmail.com", password: "password")
    @category = Category.create(name: "News")
    sign_in_as(@user)
  end

  test "get new article form and create an article" do
    get new_article_path
    assert_response :success
    assert_difference "Article.count", 1 do
      post articles_path, params: { article: { title: "India is best country to live", description: "India is best country to live because of diverse culture.", category_ids: [ "1" ] } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
  end

  test "get new article form and rejecy invalid input in article" do
    get new_article_path
    assert_response :success
    assert_no_difference "Article.count" do
      post articles_path, params: { article: { title: " ", description: "India is best country to live because of diverse culture.", category_ids: [ "1" ] } }
    end
    assert_match "issues", response.body
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end
