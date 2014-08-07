require 'test_helper'

class ArticleL10nsControllerTest < ActionController::TestCase
  setup do
    @article_l10n = article_l10ns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:article_l10ns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article_l10n" do
    assert_difference('ArticleL10n.count') do
      post :create, article_l10n: { article_id: @article_l10n.article_id, content: @article_l10n.content, display_name: @article_l10n.display_name, language_code: @article_l10n.language_code, title: @article_l10n.title }
    end

    assert_redirected_to article_l10n_path(assigns(:article_l10n))
  end

  test "should show article_l10n" do
    get :show, id: @article_l10n
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article_l10n
    assert_response :success
  end

  test "should update article_l10n" do
    patch :update, id: @article_l10n, article_l10n: { article_id: @article_l10n.article_id, content: @article_l10n.content, display_name: @article_l10n.display_name, language_code: @article_l10n.language_code, title: @article_l10n.title }
    assert_redirected_to article_l10n_path(assigns(:article_l10n))
  end

  test "should destroy article_l10n" do
    assert_difference('ArticleL10n.count', -1) do
      delete :destroy, id: @article_l10n
    end

    assert_redirected_to article_l10ns_path
  end
end
