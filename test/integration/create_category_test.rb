require 'test_helper'

# generate by using the terminal command:
# rails generate integration_test create_category

# Integration test tests an entire functionality

# I prefer using the brackets / parans than the Rails and Ruby convention of not
# using them
class CreateCategoryTest < ActionDispatch::IntegrationTest
  test 'get the new category form and create category' do
    get('/categories/new') # alternative way would be to just put the shorthand "categories_path"
    assert_response(:success)
    assert_difference 'Category.count', 1 do
      post(categories_path, params: { name: 'Sports' })
      assert_response(:redirect)
    end

    follow_redirect!

    assert_response(:success)

    # will look for the category name in the response body (which should be HTML)
    assert_match('Sports', response.body)
  end

  test 'get the new category form and reject invalid category submission' do
    get(categories_path)
    assert_response(:success)
    assert_no_difference 'Category.count' do
      post(categories_path, params: { name: '' })
    end

    # will look for the id of errors partial
    # did not implement error partial as technique seemed finicky in rails 7
    # assert_select('div#error')
  end
end
