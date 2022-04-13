require 'test_helper'

# controller test file automatically createed with the terminal command
# rails generate test_unit:scaffold category
class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: 'Sports')
    @admin_user = User.create(username: 'johndoe', email: 'johndoe@email.com', password: 'password', admin: true)
  end

  test 'should get index' do
    get(categories_url)
    assert_response :success
  end

  test 'should get new' do
    # method defined in test_helper.rb
    sign_in_as(@admin_user)
    get(new_category_url)
    assert_response :success
  end

  test 'should create category' do
    sign_in_as(@admin_user)
    assert_difference('Category.count', 1) do
      # post categories_url, params: { category: { name: 'Travel' } }
      post(categories_url, params: { name: 'Travel' })
    end

    assert_redirected_to category_url(Category.last)
  end

  test 'should show category' do
    get(category_url(@category))
    assert_response :success
  end

  test 'should not show category if not admin' do
    assert_no_difference('Category.count') do
      post(categories_url, params: { name: 'Travel' })
    end

    assert_redirected_to(categories_url)
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference("Category.count", -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end
