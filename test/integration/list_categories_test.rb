require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: 'Sports')
    @category2 = Category.create(name: 'Travel')
  end

  test 'should show categories listing' do
    get(categories_path)
    # assert_select queries the HTML in the responce body
    # here we are asserting that the 2 categories created in the setup will
    # be present in the result of a GET /categories request
    # and they will be present as links with paths that match that of the respective
    # categories
    assert_select('a[href=?]', category_path(@category.id), text: @category.name)
    assert_select('a[href=?]', category_path(@category2.id), text: @category2.name)
  end
end
